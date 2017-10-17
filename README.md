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
