# fill zpool with large file

# cfg=3*(8+3)+3=36 
# cap: 3*8*4TB=96TB(theoratical) 85TB (actual)
 
# step 1: create large file
fallocate -l 1000G ~/Documents/file1T.dat

# step 2: cp the file to zpool until 10%
for i in {1..9}
do
time cp ~/Documents/file1T.dat /tank/`date +%m%d%H%M%S`.dat
done
