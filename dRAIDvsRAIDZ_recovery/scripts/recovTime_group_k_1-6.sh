# recovery test, change number of groups
# cfg = k x (5 + 2) + 2 = c
# k={1,2,3,4,5,6} c={9,16,23,30,37,44}

################################## d p s g c = 5 2 2 1 9 ##################################
# destroy previous zpool
zpool destroy tank

# create new pool
echo "d p s g c = 5 2 2 1 9, dRAID"
zpool create -f tank draid2 cfg=9_draid2.nvl sdak sdal sdam sdan sdao sdap sdaq sdar sdas

# capaticy: 16TB 10%=1.6TB
# fill 1600GB data to fill 10%
for i in {1..80}
do
    fallocate -l 20G ~/Documents/20G.dat
    time cp ~/Documents/20G.dat /tank/`date +%m%d%H%M%S`.dat
done
rm -f ~/Documents/20G.dat

# after fill 10%, check for utilization and health status
df -h | grep tank
zpool status

# fault injection to disable a disk
DEV=sdak ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) seek=$((`blockdev --getsz /dev/$DEV` - 2048*500 )) ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) ; echo "fault injection done"
# sleep 1m ; echo "fault injection done" # wait it to complete

#check zpool status, scrub tank
zpool scrub tank

# wait until rebuilt complete
# zpool status should gives:
# scan: rebuilt 144K in 0 days 00:00:00 with 0 errors on Thu Oct 25 02:45:45 2018
for (( ; ; ))
do
        if zpool status | grep -q rebuilt
                then
                        echo "dRAID rebuilt complete!"
                        zpool status | grep rebuilt
                        break
                else
                        sleep 10m
        fi
done

# initiate resilvering for RAIDZ recovery 
zpool replace -f tank $DEV

# wait until raidz resilvering complete
# zpool status should gives:
# scan: resilvered 144K in 0 days 00:00:00 with 0 errors on Thu Oct 25 02:45:45 2018
for (( ; ; ))
do
        if zpool status | grep -q resilvered
                then
                        echo "RAIDZ resilvered complete!"
                        zpool status | grep resilvered
                        break
                else
                        sleep 10m
        fi
done


################################## d p s g c = 5 2 2 2 16 ##################################
zpool destroy tank
echo "d p s g c = 5 2 2 2 16, dRAID"
zpool create -f tank draid2 cfg=16_draid2.nvl sdad sdae sdaf sdag sdah sdai sdaj sdak sdal sdam sdan sdao sdap sdaq sdar sdas

# capaticy: 32TB 10%=3.2TB
for i in {1..80}
do
    fallocate -l 40G ~/Documents/40G.dat
    time cp ~/Documents/40G.dat /tank/`date +%m%d%H%M%S`.dat
done
rm -f ~/Documents/40G.dat
df -h | grep tank
zpool status

# fault injection to disable a disk
DEV=sdad ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) seek=$((`blockdev --getsz /dev/$DEV` - 2048*500 )) ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) ; echo "fault injection done"

zpool scrub tank
for (( ; ; ))
do
        if zpool status | grep -q rebuilt
                then
                        echo "dRAID rebuilt complete!"
                        zpool status | grep rebuilt
                        break
                else
                        sleep 10m
        fi
done
zpool replace -f tank $DEV
for (( ; ; ))
do
        if zpool status | grep -q resilvered
                then
                        echo "RAIDZ resilvered complete!"
                        zpool status | grep resilvered
                        break
                else
                        sleep 10m
        fi
done

################################## d p s g c = 5 2 2 3 23 ##################################
zpool destroy tank
echo "d p s g c = 5 2 2 3 23, dRAID"
zpool create -f tank draid2 cfg=23_draid2.nvl sdv sdw sdx sdy sdaa sdab sdac sdad sdae sdaf sdag sdah sdai sdaj sdak sdal sdam sdan sdao sdap sdaq sdar sdas

# capaticy: 49TB 10%=4.9TB
for i in {1..80}
do
    fallocate -l 60G ~/Documents/60G.dat
    time cp ~/Documents/60G.dat /tank/`date +%m%d%H%M%S`.dat
done
rm -f ~/Documents/60G.dat
df -h | grep tank
zpool status

# fault injection to disable a disk
DEV=sdv ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) seek=$((`blockdev --getsz /dev/$DEV` - 2048*500 )) ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) ; echo "fault injection done"

zpool scrub tank
for (( ; ; ))
do
        if zpool status | grep -q rebuilt
                then
                        echo "dRAID rebuilt complete!"
                        zpool status | grep rebuilt
                        break
                else
                        sleep 10m
        fi
done
zpool replace -f tank $DEV
for (( ; ; ))
do
        if zpool status | grep -q resilvered
                then
                        echo "RAIDZ resilvered complete!"
                        zpool status | grep resilvered
                        break
                else
                        sleep 10m
        fi
done

################################## d p s g c = 5 2 2 4 30 ##################################
zpool destroy tank
echo "d p s g c = 5 2 2 4 30, dRAID"
zpool create -f tank draid2 cfg=30_draid2.nvl sdo sdp sdq sdr sds sdt sdu sdv sdw sdx sdy sdaa sdab sdac sdad sdae sdaf sdag sdah sdai sdaj sdak sdal sdam sdan sdao sdap sdaq sdar sdas

# capaticy: 64TB 10%=6.4TB
for i in {1..80}
do
    fallocate -l 80G ~/Documents/80G.dat
    time cp ~/Documents/80G.dat /tank/`date +%m%d%H%M%S`.dat
done
rm -f ~/Documents/80G.dat
df -h | grep tank
zpool status

# fault injection to disable a disk
DEV=sdo ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) seek=$((`blockdev --getsz /dev/$DEV` - 2048*500 )) ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) ; echo "fault injection done"

zpool scrub tank
for (( ; ; ))
do
        if zpool status | grep -q rebuilt
                then
                        echo "dRAID rebuilt complete!"
                        zpool status | grep rebuilt
                        break
                else
                        sleep 10m
        fi
done
zpool replace -f tank $DEV
for (( ; ; ))
do
        if zpool status | grep -q resilvered
                then
                        echo "RAIDZ resilvered complete!"
                        zpool status | grep resilvered
                        break
                else
                        sleep 10m
        fi
done

################################## d p s g c = 5 2 2 5 37 ##################################
zpool destroy tank
echo "d p s g c = 5 2 2 5 37, dRAID"
zpool create -f tank draid2 cfg=37_draid2.nvl sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu sdv sdw sdx sdy sdaa sdab sdac sdad sdae sdaf sdag sdah sdai sdaj sdak sdal sdam sdan sdao sdap sdaq sdar sdas

# capaticy: 80TB 10%=8TB
for i in {1..100}
do
    fallocate -l 80G ~/Documents/80G.dat
    time cp ~/Documents/80G.dat /tank/`date +%m%d%H%M%S`.dat
done
rm -f ~/Documents/80G.dat
df -h | grep tank
zpool status

# fault injection to disable a disk
DEV=sdh ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) seek=$((`blockdev --getsz /dev/$DEV` - 2048*500 )) ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) ; echo "fault injection done"

zpool scrub tank
for (( ; ; ))
do
        if zpool status | grep -q rebuilt
                then
                        echo "dRAID rebuilt complete!"
                        zpool status | grep rebuilt
                        break
                else
                        sleep 10m
        fi
done
zpool replace -f tank $DEV
for (( ; ; ))
do
        if zpool status | grep -q resilvered
                then
                        echo "RAIDZ resilvered complete!"
                        zpool status | grep resilvered
                        break
                else
                        sleep 10m
        fi
done

################################## d p s g c = 5 2 2 6 44 ##################################
zpool destroy tank
echo "d p s g c = 5 2 2 6 44, dRAID"
zpool create -f tank draid2 cfg=44_draid2.nvl sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu sdv sdw sdx sdy sdaa sdab sdac sdad sdae sdaf sdag sdah sdai sdaj sdak sdal sdam sdan sdao sdap sdaq sdar sdas

# capaticy: 97TB 10%=10TB
for i in {1..100}
do
    fallocate -l 100G ~/Documents/100G.dat
    time cp ~/Documents/100G.dat /tank/`date +%m%d%H%M%S`.dat
done
rm -f ~/Documents/100G.dat
df -h | grep tank
zpool status

# fault injection to disable a disk
DEV=sda ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) seek=$((`blockdev --getsz /dev/$DEV` - 2048*500 )) ; dd bs=512 if=/dev/zero of=/dev/$DEV count=$((2048*500)) ; echo "fault injection done"

zpool scrub tank
for (( ; ; ))
do
        if zpool status | grep -q rebuilt
                then
                        echo "dRAID rebuilt complete!"
                        zpool status | grep rebuilt
                        break
                else
                        sleep 10m
        fi
done
zpool replace -f tank $DEV
for (( ; ; ))
do
        if zpool status | grep -q resilvered
                then
                        echo "RAIDZ resilvered complete!"
                        zpool status | grep resilvered
                        break
                else
                        sleep 10m
        fi
done


