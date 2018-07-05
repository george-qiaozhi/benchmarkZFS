#for i in {1..100}
#do
#cat /media/pool/file.tmp >> /media/pool/100G.dat
#done
echo date
#fill zpool with 300G data (50% utilization)
#fill zpool with 469G data (75% utilization)
#fill zpool with 156G data (25% utilization)
#100G
cat /media/pool/100G.dat > /tankR5/file100G.dat
#56G
for i in {1..56}
do
cat /media/pool/1G.dat >> /tankR5/file56G.dat
done

# pre error injection status check
echo "====> df -h"
df -h
echo "====> zpool status tankR5"
zpool status tankR5
echo "====> zpool iostat -v"
zpool iostat -v

echo date
echo "====> start pv"
# start error injection, flush one of the drive
pv < /dev/zero > /dev/sde

sleep 1h #make sure pv finished

echo date
# post error injection status check
echo "====> df -h"
df -h
echo "====> zpool status tankR5"
zpool status tankR5
echo "====> zpool iostat -v"
zpool iostat -v

# notify zfs to check integrety
echo "====>zpool scrub & zpool status" 
zpool scrub tankR5
zpool status tankR5

# replace drive with disk format -f
echo "====>zpool replace sde & check status"
zpool replace -f tankR5 /dev/sde
zpool status tankR5

#sleep and check again
echo "====>sleep 1h and check again"
sleep 1h
zpool status tankR5

