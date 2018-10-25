# fill zpool with large file
# cfg = 3 x (5 + 2) +3 = 24  Cap.: 49TB

# step 1: create large file
fallocate -l 1000G ~/Documents/1t.dat

# step 2: fill zpool to 10 TB (about 20%)
for i in {1..10}
do
time cp ~/Documents/1t.dat /tank/`date +%m%d%H%M%S`.dat
done

rm -f ~/Documents/1t.dat
