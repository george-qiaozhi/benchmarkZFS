#RAID 5 using 3, 3, 4 + 1
#RAID 6 using 2, 3 + 2
#RAM = 8, 16, 32G

echo "R5 2+1"
#create zpool
zpool destroy tank
zpool create -f tank raidz1 sdb sdc sdd

#run bonnie++
#skip per char test -f
#quite mode -q
#execute 5 times -x 5
date +%m%d%H%M%S
bonnie++ -d /tank -u root -x 5 -f -q > result.txt
date +%m%d%H%M%S

echo "R5 3+1"
zpool destroy tank
zpool create -f tank raidz1 sdb sdc sdd sde
date +%m%d%H%M%S
bonnie++ -d /tank -u root -x 5 -f -q >> result.txt
date +%m%d%H%M%S

echo "R5 4+1"
zpool destroy tank
zpool create -f tank raidz1 sdb sdc sdd sde sdf
date +%m%d%H%M%S
bonnie++ -d /tank -u root -x 5 -f -q >> result.txt
date +%m%d%H%M%S

echo "R6 2+2"
zpool destroy tank
zpool create -f tank raidz2 sdb sdc sdd sde
date +%m%d%H%M%S
bonnie++ -d /tank -u root -x 5 -f -q >> result.txt
date +%m%d%H%M%S

echo "R6 3+2"
zpool destroy tank
zpool create -f tank raidz2 sdb sdc sdd sde sdf
date +%m%d%H%M%S
bonnie++ -d /tank -u root -x 5 -f -q >> result.txt
date +%m%d%H%M%S

# c d slow but b e f fast
# test them with RAID 0

# zpool destroy tank
# zpool create -f tank raidz1 sdb sdc sdd
# bonnie++ -d /tank -u root -x 5 -f -q > result.txt

# zpool destroy tank
# zpool create -f tank raidz1 sde sdc sdd
# bonnie++ -d /tank -u root -x 5 -f -q >> result.txt

# zpool destroy tank
# zpool create -f tank raidz1 sdf sdc sdd
# bonnie++ -d /tank -u root -x 5 -f -q >> result.txt

# zpool destroy tank
# zpool create -f tank raidz1 sdb sdc sde
# bonnie++ -d /tank -u root -x 5 -f -q >> result.txt

# zpool destroy tank
# zpool create -f tank raidz1 sdb sdc sdf
# bonnie++ -d /tank -u root -x 5 -f -q >> result.txt

# zpool destroy tank
# zpool create -f tank raidz1 sdb sdd sde
# bonnie++ -d /tank -u root -x 5 -f -q >> result.txt

# zpool destroy tank
# zpool create -f tank raidz1 sdb sdd sdf
# bonnie++ -d /tank -u root -x 5 -f -q >> result.txt

# zpool destroy tank
# zpool create -f tank raidz1 sdc sde sdf
# bonnie++ -d /tank -u root -x 5 -f -q >> result.txt

# zpool destroy tank
# zpool create -f tank raidz1 sdd sde sdf
# bonnie++ -d /tank -u root -x 5 -f -q >> result.txt

# zpool destroy tank
# zpool create -f tank raidz1 sdb sde sdf
# bonnie++ -d /tank -u root -x 5 -f -q >> result.txt