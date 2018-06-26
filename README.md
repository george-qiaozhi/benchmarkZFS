# ZFS benchmarking
benchmarking ZFS's I/O, dRAID, and resilvering performance, using SSD or NVMe, various stripe width, DRAM size, zpool utilization, and so on...

### System
- remote portal: comely[dot]{nmc}[dot]org
- storage servers: {10.15.5.x} {centOS 7.5/1804} {myri10ge}
	- zfs_server_103
		- NFS server
		- RAIDZ2 5+2 (7x4TB HDD 18TB zpool capacity) 
		- AMD 6176 24 core
	- zfs_server_104
		- NFS client
		- 5x4TB HDD
		- AMD 6176 24 core
	- JBOD_server_110
    	- NFS client
    	- JBOD server, 45x4TB HDD. 
    	- Supermicro SC847E26-RJBOD1
    	- 2 x Xeon E5620 16 core
	- NFS mounted on `/nfsZpool`
### Setup NFS:
- [NFS Server and Client Installation on CentOS 7](https://www.howtoforge.com/nfs-server-and-client-on-centos-7)
- install package: `yum install nfs-utils`
- Server end: 
	- grant proper privilege: 
      ```
      chmod -R 755 /nfsZpool
      chown nfsnobody:nfsnobody /nfsZpool
      ```
	- start the service and enable at boot time
      ```
      systemctl enable rpcbind
      systemctl enable nfs-server
      systemctl enable nfs-lock
      systemctl enable nfs-idmap
      systemctl start rpcbind
      systemctl start nfs-server
      systemctl start nfs-lock
      systemctl start nfs-idmap
      ```
    - specify NFS directory in `vi /etc/exports`
      ```
      /nfsZpool ip.add.0.0/24(rw,sync,no_root_squash,no_all_squash)
      ```
    - start NFS service `systemctl restart nfs-server`
    - add the NFS service override in CentOS7 firewall-cmd public zone service
      ```
      firewall-cmd --permanent --zone=public --add-service=nfs
      firewall-cmd --permanent --zone=public --add-service=mountd
      firewall-cmd --permanent --zone=public --add-service=rpc-bind
      firewall-cmd --reload
      ```
- Client end:
	- same firewall setting
	- test with `showmount -e 10.15.5.xxx`, if success, should display `Export list for 10.15.5.103:
/nfsZpool *`
	- mount the NFS shared dir: `mkdir -p /nfsZpool & mount -t nfs 10.15.5.103:/nfsZpool`
	- permanent mounting need to modify `fstab` file via `vi /etc/fstab`, and add `10.15.5.xxx:/nfsZpool  /nfsZpool	nfs defaults 0 0` to the file


## 1. Use Bonnie++ benchmarking ZFS I/O for RAIZ1~3
We use bonnie++ to benchmarking the performance of the zfs
### 1.1 - limit RAM size
Bonnie++ always use dataset that x2 the system RAM size to avoid caching effect. Our system has 32GB RAM installed, to change the system RAM via kernel boot parameter:
`sudo vi /etc/default/grub`

In the editor window, move the cursor to the line beginning with "GRUB_CMDLINE_LINUX_DEFAULT" then edit that line, adding your parameter(s) to the text inside the double-quotes after the words "quiet splash". To limit RAM size to 8G, do 
>..."quiet splash mem=8G"

Then update the grub `sudo update-grub` and reboot `sudo reboot`

link to Kernel boot parameters: [https://wiki.ubuntu.com/Kernel/KernelBootParameters]

my `/etc/default/grub` file also attached.

### 1.2.1 - create zpool using RAIDZ1

```
#RAID 5 3d+1p
zpool create -f tank raidz1 sdc sdd sde sdf
```

### 1.2.2 - execute bonnie++ 
`bonnie++ -d /tankR5 -u root -x 5 -f -q >> result.txt`

script to use: 
bonnieBench.sh(zpool with RAID5/RAID6 using different number of data disk and parity disk) 
exec.sh(call bonnieBench.sh and log output)

### 1.3 process data
use `python result_filtering.py` to parse the result and paste to excel or google sheet.

## 2. Simulate a Disk Failure without simulater 
There are several ways to simulate a disk failure in ZFS:
- Physically remove disk from active zpool
- Disconnect power source of disk
- Completely overwrite disk with different filesystem other than ZFS

Amoung these methods, disk overwrite is the only non-physical approach that could be performed automaticlly.
Methodology:
- fill disk with random data to simulate workload. e.g, `openssl rand -out sample.txt -base64 $(( 2**30 * 3/4 ))` will create a 1GB file.
- flush the underneath disk via IO bus. It will zero out entire disk including the formatting headers or partition table. e.g, `pv < /dev/zero > /dev/sdx` will inject zeros to device sdx.
- notify ZFS to scrub system for error check via `zpool scrub poolname`.
- once ZFS detect disk failure, replace it with new disk. We can just reformat the disk then plug it back via `zpool replace -f poolname /dev/sdx`
- after replace disk, zfs will start the disk rebuild process. wait, chill, sleep for a while, then come back.
- after rebuilt, `zpool status poolname` will show the resilvering duration.
