# fill zpool with large file

# step 1: create large file
fallocate -l 1000G ~/Documents/1t.dat

# step 2: cp the file to zpool to fill 4 TB
for i in {1..4}
do
time cp ~/Documents/1t.dat /tank/`date +%m%d%H%M%S`.dat
done