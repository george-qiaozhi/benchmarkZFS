#for i in {1..100}
#do
#cat /media/pool/file.tmp >> /media/pool/100G.dat
#done

#fill zpool with 300G data (50% utilization)
#fill zpool with 469G data (75% utilization)
#for i in {1..3}
for i in {1..169}
do
#cat /media/pool/100G.dat > /tankR5/file_$i.dat
cat /media/pool/1G.dat >> /tankR5/file169G.dat
done

# pre error injection status check
echo "====> df -h"
df -h
echo "====> zpool status tankR5"
zpool status tankR5
echo "====> zpool iostat -v"
zpool iostat -v

# start error injection, flush one of the drive
pv < /dev/zero > /dev/sdd

sleep 1h #make sure pv finished
# post error injection status check
echo "====> df -h"
df -h
echo "====> zpool status tankR5"
zpool status tankR5
echo "====> zpool iostat -v"
zpool iostat -v

# notify zfs to check integrety 
zpool scrub tankR5
zpool status tankR5

# replace drive with disk format -f
zpool replace -f tankR5 /dev/sdb
zpool status tankR5

#sleep and check again
sleep 1h
zpool status tankR5

