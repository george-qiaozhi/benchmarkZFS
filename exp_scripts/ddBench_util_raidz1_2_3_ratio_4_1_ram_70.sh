# run: ./ddBench.sh &> output/dir 
# benchmarking raidz 1, 2, 3 with storage utilization from 0 to 16TB
# DRAM:	70GB
# Disk: 4TB
# parity ratio 4:1

# use dd if=/dev/urandom of=xx.dat bs=1G count=150 to fill the zpool and record MB/s
# zpool create -f ztank1 raidz1 sda sdb sdc sdd sde
# 		  ztank2 raidz2 sda sdb sdc sdd sde sdf sdg sdh sdi sdj
#		  ztank3 raidz3 sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo

echo "******ztank1***** " & date +%m-%d-%H-%M:%S
# create ztank1
zpool destroy ztank1
zpool create -f ztank1 raidz1 sdaa sdab sdac sdad sdae
zpool status ztank1

# dd 150GB at a time and record MB/s until full, for 15TB pool, take about 100 times

for i in {1..100}
do
dd if=/dev/urandom of=/ztank1/`date +%m%d%H%M%S`.dat bs=10M count=15000
done

echo "******z1 status***** " & date +%m-%d-%H-%M:%S
zpool status ztank1
df -h

# create ztank2

zpool create -f ztank2 raidz2 sdaa sdab sdac sdad sdae sdaf sdag sdah sdai sdaj
zpool status ztank2

# dd 270GB at a time and record MB/s until full, for 27TB pool, take about 100 times

for i in {1..100}
do
dd if=/dev/urandom of=/ztank2/`date +%m%d%H%M%S`.dat bs=10M count=27000
done

echo "****** z2 status" & date +%m-%d-%H-%M:%S
zpool status ztank2 
df -h

# create ztank3
zpool destroy ztank2
zpool create -f ztank3 raidz3 sdaa sdab sdac sdad sdae sdaf sdag sdah sdai sdaj sdak sdal sdam sdan sdao
zpool status ztank3

# dd 390GB at a time and record MB/s until full, for 39TB pool, take about 100 times

for i in {1..100}
do
dd if=/dev/urandom of=/ztank3/`date +%m%d%H%M%S`.dat bs=10M count=39000
done

echo "****** z3 status" & date +%m-%d-%H-%M:%S
zpool status ztank3
df -h

