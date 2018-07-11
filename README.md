# ZFS performance evaluation
benchmarking ZFS's I/O, dRAID, and resilvering performance, using HDD, SSD or NVMe, various stripe width, DRAM size, zpool utilization, and so on...

## Environment
#### System
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
#### NFS:
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


## Use Bonnie++ benchmarking ZFS I/O for RAIZ1~3
At this moment, we use bonnie++ to benchmarking the performance of the zfs. We use sequential block *read/write/rewrite* to simulate large I/O. 
##### limit RAM size
Bonnie++ always use dataset that x2 the system RAM size to avoid caching effect. Our system has 32GB RAM installed, to change the system RAM via kernel boot parameter:
`sudo vi /etc/default/grub`

In the editor window, move the cursor to the line beginning with "GRUB_CMDLINE_LINUX_DEFAULT" then edit that line, adding your parameter(s) to the text inside the double-quotes after the words "quiet splash". To limit RAM size to 8G, do 
>..."quiet splash mem=8G"

Then update the grub `sudo update-grub` and reboot `sudo reboot`

link to Kernel boot parameters: [https://wiki.ubuntu.com/Kernel/KernelBootParameters]

my `/etc/default/grub` file also attached.

##### create zpool using RAIDZ1

```
#RAID 5 4:1 parity ratio
zpool create -f tank raidz1 sdaa sdab sdac sdad sdae
```

##### execute bonnie++ 3 times
`bonnie++ -d /tank -u root -x 3 -f -q >> result.txt`

##### or use dd to clone 150GB data to zpool at a time, dd will report performance in MB/s.
`dd if=/dev/urandom of=/tank/`date +%m%d%H%M%S`.dat bs=10M count=15000`

Always redirect results into a log file using `dd &> xx.log`

script to use: 
bonnieBench.sh(zpool with RAID5/RAID6 using different number of data disk and parity disk) 
exec.sh(call bonnieBench.sh and log output)

##### process data
use `python result_filtering.py` to parse the result and paste to excel or google sheet.

## Simulate Disk Failures
There are several ways to simulate a disk failure in ZFS. We use last one in our experiments. 
- Physically
	- remove disk from active zpool
	- Disconnect power source of disk
- Reformat the disk [**not working in our experiment**]
- declare SCSI device bad in linux [**not working in our experiment**]
- use dm device on top of scsi device to inject error [**not working in our experiment**]
- create zpool in VM, injecting error from VM
- Injecting error to system reserved area in disk drives (zero out first and last few MB)

#### Methodology:
- fill disk with random data to simulate workload. e.g.:
	- `dd if=/dev/urandom of=/output/dir/random.dat bs=10M count=10000`(SLOW)
	- `openssl rand -out random.dat -base64 $(( 2**30 * 3/4 ))` will create a 1GB file. (FASTER)
	- `fallocate -l 1000G ~/directory/1t.dat` creates a 1TB file. (INSTANT, no matter size)
- inject error to disk so ZFS will treat it as failure disk
	- flush the underneath disk via IO bus. It will zero out entire disk including the formatting headers or partition table. e.g, `pv < /dev/zero > /dev/sdx` will inject zeros to device sdx. (SLOW)
	- or, erase first and last few MB of disk.e.g., 
	```dd bs=512 if=/dev/zero of=/dev/sdx count=$((2048*500)) seek=$((`blockdev --getsz /dev/sdx` - 2048*500 ))```
	will zero out last 500mb disk space, then 
	```dd bs=512 if=/dev/zero of=/dev/sdx count=$((2048*500))``` 
	to zero first 500mb. (FASTER)
- notify ZFS to scrub system for error check via `zpool scrub poolname`.
- once ZFS detect disk failure, replace it with new disk. We can just reformat the disk then plug it back via `zpool replace -f poolname /dev/sdx`
- after replace disk, zfs will start the disk rebuild process. wait, chill, sleep for a while, then come back.
- after rebuilt, `zpool status poolname` will show the resilvering duration.

**NOTE**: *usually, the partition / format / label information are kept at the first 1Mb. RAID configuration are kept at the last 1Mb . ZFS reserved the last 8Mb next to the RAID config area.*
`fdisk -l /dev/sdx` will show that a typical ZFS managed disk drive have following profile:
- Sector *2048* to *7,812,481,023* is used by zfs, which is around 3.6TB available storage for ZFS from a 4TB HDD.
- Sector *7812481024* to *7812497407* is solars reserved, which is around 8Mb used to store zpool information.
The total number of sector is *7812499456*
- This left the room for *0~2047* sectors, or 1MB of space reserved by system (e.g., label type: gpt). And the last 2048 sectors, reserved by RAID card for its configuration. And the rest by ZFS filesystem. (Each sector is 512 byte)

## dRAID evaluation
We follow the OpenZFS summit from 2015 to 17, Issac Huang's talk and post. 
[dRAID HOWTO](https://github.com/zfsonlinux/zfs/wiki/dRAID-HOWTO)

*As of today (June 28, 2018), dRAID uses ZFS 0.7 release and didn't follows the latest official release. Build dRAID requires both spl and zfs package from github, but official release already merged two.*

#### Following steps go throught the install and setup process for dRAID.
1.	install [spl](https://github.com/zfsonlinux/spl)
	```
    git clone https://github.com/zfsonlinux/spl
    git checkout spl-0.7-release
    ./autogen.sh
    ./configure --enable-debug
    make
    make install
    ```
2.	install [zfs](https://github.com/thegreatgazoo/zfs) from Issac Huang's repo
	```
    git clone https://github.com/thegreatgazoo/zfs.git
    git checkout draid
    * build and install same as spl *
    ```
3. use draid
	```
    modprobe zfs zfs_vdev_scrub_max_active=10 zfs_vdev_async_write_min_active=4 draid_debug_lvl=5
    ```
4. configure draid
	```
    draidcfg -p 1 -d 4 -s 2 -n 17 17.nvl
    ```
5. create draid array
	```
    zpool create -f tank draid1 cfg=17.nvl sdd sde sdf sdg sdh \ 
    					   sdi sdj sdk sdl sdm \ 
                                           sdn sdo sdp sdq sdr \ 
                                           sds sdt
    ```


## Git tips
Cache git credential 16 weeks to mute git push password/username prompt.
`git config --global credential.helper 'cache --timeout=10000000'`
Now push one last time.
`git push -u origin master`

## Bug Report
- To be added

## Responsibility
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

