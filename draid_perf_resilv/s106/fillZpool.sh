# fill zpool with large file

# step 1: create large file
fallocate -l 1000G ~/Documents/1t.dat

# step 2: cp the file to zpool
time cp ~/Documents/1t.dat /tank/`date +%m%d%H%M%S`.dat