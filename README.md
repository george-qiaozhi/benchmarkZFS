# benchmark ZFS Recovery Performance
benchmarking zfs performance and resilience on different raidz setting, zpool utilization, and so on...

## 1. Use Bonnie++ benchmarking ZFS I/O for RAID5 & RAID6
We use bonnie++ to benchmarking the performance of the zfs
### Step 1 - limit RAM size
Bonnie++ always use dataset that x2 the system RAM size to avoid caching effect. Our system has 32GB RAM installed, to change the system RAM via kernel boot parameter:
`sudo vi /etc/default/grub`

In the editor window, move the cursor to the line beginning with "GRUB_CMDLINE_LINUX_DEFAULT" then edit that line, adding your parameter(s) to the text inside the double-quotes after the words "quiet splash". To limit RAM size to 8G, do 
>..."quiet splash mem=8G"

Then update the grub `sudo update-grub` and reboot `sudo reboot`

link to Kernel boot parameters: [https://wiki.ubuntu.com/Kernel/KernelBootParameters]

my `/etc/default/grub` file also attached.

### Step 2.1 - create zpool using RAID5 and RAID6

```
# RAID 5 3d+1p
zpool create -f tank raidz1 sdc sdd sde sdf
```
### Step 2.2 - execute bonnie++ 
`bonnie++ -d /tankR5 -u root -x 5 -f -q >> result.txt`

script to use: 
bonnieBench.sh(zpool with RAID5/RAID6 using different number of data disk and parity disk) 
exec.sh(call bonnieBench.sh and log output)

### Step 3 process data
use `python result_filtering.py` to parse the result and paste to excel or google sheet.

## Disk Failure 
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
