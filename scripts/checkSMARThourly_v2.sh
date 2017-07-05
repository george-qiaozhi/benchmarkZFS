#!/bin/bash
# This script checks the health of disks

#credit:	Chris Sidiropoulos
#link:		https://csidiropoulos.wordpress.com/2013/12/13/bash-script-to-monitor-hard-disk-health-and-send-an-e-mail-on-error/

#disk to check
disks="
/dev/sdb
/dev/sdc
/dev/sdd
/dev/sde"

#path to keep the smart data for each disk
logpath="/home/zfs/SMART_cron/"

#create timestamp
timestamp=$(date +%Y%m%d%H)

#checking smart data
for disk in $disks
do
	mkdir -p $logpath/${disk:5} 
	smartctl -A $disk > $logpath/${disk:5}/$timestamp.smart 
done
