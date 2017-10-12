# benchmarkZFS
benchmarking zfs performance and resilience on different raidz setting, zpool utilization, and so on...

#########################
# 1. Use Bonnie++ benchmarking ZFS I/O for RAID 5 & RAID 6 (RAIDZ1 and RAIDZ2)
#########################
We use bonnie++ to benchmarking the performance of the zfs

###### limit RAM size ######
#Bonnie++ always use dataset that x2 the system RAM size to avoid caching effect. Our system has 32GB RAM installed, to change the system RAM via kernel boot parameter.

sudo vi /etc/default/grub 

#In the editor window, move the cursor to the line beginning with "GRUB_CMDLINE_LINUX_DEFAULT" then edit that line, adding your parameter(s) to the text inside the double-quotes after the words "quiet splash". To limit RAM size to 8G, do 

..."quiet splash mem=8G". 

#Then update the grub via 

sudo update-grub

#and reboot computer

sudo reboot

#link to Kernel boot parameters: https://wiki.ubuntu.com/Kernel/KernelBootParameters
