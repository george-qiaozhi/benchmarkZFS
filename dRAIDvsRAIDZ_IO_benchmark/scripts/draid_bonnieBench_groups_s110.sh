# draid performance evaluation
# bonnie++ 
# increase # of raid groups in draid
# (1+4)(1+4)+2 = 12 (2x5+2)
# (1+4)(1+4)(1+4)+2 = 17 (3x5+2)
# (1+4)(1+4)(1+4)(1+4)+2 = 22 (4x5+2)
# (1+4)(1+4)(1+4)(1+4)(1+4)+2 = 27 (5x5+2)

# configuration file 12.nvl 17.nvl 22.nvl 27.nvl already created

# remove the previously zpool
zpool destroy tank
# create draid (2x5+2)
zpool create -f tank draid1 cfg=12.nvl sda sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm
# bonnieBench the draid zpool 3 times
bonnie++ -d /tank -u root -x 3 -f -q &> result.txt
date +%m%d%H%M%S

# remove the previously zpool
zpool destroy tank
# create draid (3x5+2)
zpool create -f tank draid1 cfg=17.nvl sda sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr
# bonnieBench the draid zpool 3 times
bonnie++ -d /tank -u root -x 3 -f -q &>> result.txt
date +%m%d%H%M%S

# remove the previously zpool
zpool destroy tank
# create draid (4x5+2)
zpool create -f tank draid1 cfg=22.nvl sda sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu sdv sdw
# bonnieBench the draid zpool 3 times
bonnie++ -d /tank -u root -x 3 -f -q &>> result.txt
date +%m%d%H%M%S

# remove the previously zpool
zpool destroy tank
# create draid (5x5+2)
zpool create -f tank draid1 cfg=27.nvl sda sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu sdv sdw sdx sdy sdz sdaa sdab
# bonnieBench the draid zpool 3 times
bonnie++ -d /tank -u root -x 3 -f -q &>> result.txt
date +%m%d%H%M%S





