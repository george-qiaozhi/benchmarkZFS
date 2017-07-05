#check_smart.sh

#get environment information
yr=$(date +%Y)
Mo=$(date +%m)
Dy=$(date +%d)
hr=$(date +%H)

#echo $yr-$Mo-$Dy-$hr

#***************************************************
#******** find disk model and serial number
#***************************************************
# model_sda=$(hdparm -I /dev/sda |grep "Model Number")
# serial_sda=$(hdparm -I /dev/sda |grep "Serial Number")
# echo "/dev/sda: "$model_sda" | "$serial_sda

# extract disk serial number
#sdb
serial_sdb=$(hdparm -I /dev/sdb | grep 'Serial Number:') # 1~20 for "Serical Number: ", 21~41 for actual number
serial_sdb=${serial_sdb:21}
#echo ${#serial_sda} # size 20
#sdc
serial_sdc=$(hdparm -I /dev/sdc | grep 'Serial Number:') # 1~20 for "Serical Number: ", 21~41 for actual number
serial_sdc=${serial_sdc:21}
#sdd
serial_sdd=$(hdparm -I /dev/sdd | grep 'Serial Number:') # 1~20 for "Serical Number: ", 21~41 for actual number
serial_sdd=${serial_sdd:21}
#sde
serial_sde=$(hdparm -I /dev/sde | grep 'Serial Number:') # 1~20 for "Serical Number: ", 21~41 for actual number
serial_sde=${serial_sde:21}


# prepare smartdata filename
timestamp=$yr$Mo$Dy$hr
#create directory if not exist
mkdir -p /home/zfs/SMART_cron/${serial_sdb}
mkdir -p /home/zfs/SMART_cron/${serial_sdc}
mkdir -p /home/zfs/SMART_cron/${serial_sdd}
mkdir -p /home/zfs/SMART_cron/${serial_sde}
# sent smartdata to file
smartctl -A /dev/sdb > /home/zfs/SMART_cron/${serial_sdb}/${timestamp}.smart 2>&1
smartctl -A /dev/sdc > /home/zfs/SMART_cron/${serial_sdc}/${timestamp}.smart 2>&1
smartctl -A /dev/sdd > /home/zfs/SMART_cron/${serial_sdd}/${timestamp}.smart 2>&1
smartctl -A /dev/sde > /home/zfs/SMART_cron/${serial_sde}/${timestamp}.smart 2>&1






