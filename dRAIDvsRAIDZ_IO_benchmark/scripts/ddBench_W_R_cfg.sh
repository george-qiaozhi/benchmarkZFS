######### change group# g ##########
# d p g s c, 5 1 1 1 7
zpool destroy tank
echo "d p g s c, 5 1 1 1 7, dRAID MB/s"
zpool create -f tank draid1 cfg=7_draid1.nvl sda sdb sdc sdd sde sdf sdg
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

zpool destroy tank
echo "d p g s c, 5 1 1 1 7, RAIDZ MB/s"
zpool create -f tank raidz1 sda sdb sdc sdd sde sdf spare sdg
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

# d p g s c, 5 1 2 1 13
zpool destroy tank
echo "d p g s c, 5 1 2 1 13, dRAID MB/s"
zpool create -f tank draid1 cfg=13_draid1.nvl sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

zpool destroy tank
echo "d p g s c, 5 1 2 1 13, RAIDZ MB/s"
zpool create -f tank raidz1 sda sdb sdc sdd sde sdf raidz1 sdg sdh sdi sdj sdk sdl spare sdm 
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

# d p g s c, 5 1 3 1 19
zpool destroy tank
echo "d p g s c, 5 1 3 1 19, dRAID MB/s"
zpool create -f tank draid1 cfg=19_draid1.nvl sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

zpool destroy tank
echo "d p g s c, 5 1 3 1 19, RAIDZ MB/s"
zpool create -f tank raidz1 sda sdb sdc sdd sde sdf raidz1 sdg sdh sdi sdj sdk sdl raidz1 sdm sdn sdo sdp sdq sdr spare sds
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

# d p g s c, 5 1 4 1 25
zpool destroy tank
echo "d p g s c, 5 1 4 1 25, dRAID MB/s"
zpool create -f tank draid1 cfg=25_draid1.nvl sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu sdv sdw sdx sdy
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

zpool destroy tank
echo "d p g s c, 5 1 4 1 25, RAIDZ MB/s"
zpool create -f tank raidz1 sda sdb sdc sdd sde sdf raidz1 sdg sdh sdi sdj sdk sdl raidz1 sdm sdn sdo sdp sdq sdr raidz1 sds sdt sdu sdv sdw sdx spare sdy
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

# d p g s c, 5 1 5 1 31
zpool destroy tank
echo "d p g s c, 5 1 5 1 31, dRAID MB/s"
zpool create -f tank draid1 cfg=31_draid1.nvl sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu sdv sdw sdx sdy sdaa sdab sdac sdad sdae sdaf
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

zpool destroy tank
echo "d p g s c, 5 1 5 1 31, RAIDZ MB/s"
zpool create -f tank raidz1 sda sdb sdc sdd sde sdf raidz1 sdg sdh sdi sdj sdk sdl raidz1 sdm sdn sdo sdp sdq sdr raidz1 sds sdt sdu sdv sdw sdx raidz1 sdy sdaa sdab sdac sdad sdae spare sdaf
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

# d p g s c, 5 1 6 1 37
zpool destroy tank
echo "d p g s c, 5 1 6 1 37, dRAID MB/s"
zpool create -f tank draid1 cfg=37_draid1.nvl sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu sdv sdw sdx sdy sdaa sdab sdac sdad sdae sdaf sdag sdah sdai sdaj sdak sdal
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

zpool destroy tank
echo "d p g s c, 5 1 6 1 37, RAIDZ MB/s"
zpool create -f tank raidz1 sda sdb sdc sdd sde sdf raidz1 sdg sdh sdi sdj sdk sdl raidz1 sdm sdn sdo sdp sdq sdr raidz1 sds sdt sdu sdv sdw sdx raidz1 sdy sdaa sdab sdac sdad sdae raidz1 sdaf sdag sdah sdai sdaj sdak spare sdal
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

# d p g s c, 5 1 7 1 43
zpool destroy tank
echo "d p g s c, 5 1 7 1 43, dRAID MB/s"
zpool create -f tank draid1 cfg=43_draid1.nvl sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu sdv sdw sdx sdy sdaa sdab sdac sdad sdae sdaf sdag sdah sdai sdaj sdak sdal sdam sdan sdao sdap sdaq sdar
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

zpool destroy tank
echo "d p g s c, 5 1 7 1 43, RAIDZ MB/s"
zpool create -f tank raidz1 sda sdb sdc sdd sde sdf raidz1 sdg sdh sdi sdj sdk sdl raidz1 sdm sdn sdo sdp sdq sdr raidz1 sds sdt sdu sdv sdw sdx raidz1 sdy sdaa sdab sdac sdad sdae raidz1 sdaf sdag sdah sdai sdaj sdak raidz1 sdal sdam sdan sdao sdap sdaq spare sdar
# test for write and read
dd bs=16M if=~/Documents/file100G.dat of=/tank/test.dat
dd bs=16M if=/tank/test.dat of=/dev/null

