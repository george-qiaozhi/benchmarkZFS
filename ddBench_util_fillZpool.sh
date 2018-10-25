# fill zpool with large file s106

# draid 3*(1+1)+1=7 
# cap: 3*1*4TB=12TB 11TB (actual)
 
for i in {1..40}
do
# step 1: create large file
fallocate -l 200G ~/Documents/file200G.dat

# step 2: cp the file to zpool until 70%

# prepare file name using date/time format
VAR=`date +%m%d%H%M%S`

# test for write performance
dd if=~/Documents/file200G.dat of=/tank/$VAR.dat bs=16M &>> write_dd.txt

# then test for read performance 
dd if=/tank/$VAR.dat of=/dev/null bs=16M &>> read_dd.txt

done
