# benchmark ZFS Recovery Performance
benchmarking zfs performance and resilience on different raidz setting, zpool utilization, and so on...

## 1. Use Bonnie++ benchmarking ZFS I/O for RAID5 & RAID6
We use bonnie++ to benchmarking the performance of the zfs
### limit RAM size
Bonnie++ always use dataset that x2 the system RAM size to avoid caching effect. Our system has 32GB RAM installed, to change the system RAM via kernel boot parameter:
`sudo vi /etc/default/grub`

In the editor window, move the cursor to the line beginning with "GRUB_CMDLINE_LINUX_DEFAULT" then edit that line, adding your parameter(s) to the text inside the double-quotes after the words "quiet splash". To limit RAM size to 8G, do 
>..."quiet splash mem=8G"

Then update the grub `sudo update-grub` and reboot `sudo reboot`

link to Kernel boot parameters: [https://wiki.ubuntu.com/Kernel/KernelBootParameters]

my `/etc/default/grub` file also attached.

### execute bonnie++ 
`bonnie++ -d /tankR5 -u root -x 5 -f -q >> result.txt`

then use `python result_filtering.py` to parse the result and paste to excel or google sheet.

### create zpool using RAID5 and RAID6


