# test for write and read
fallocate -l 20G ~/Documents/file20G.dat
for i in {1..100}
do
    dd bs=16M if=~/Documents/file20G.dat of=/tank/test$i.dat
    dd bs=16M if=/tank/test$i.dat of=/dev/null
    sleep 1m
done
# rm -f /tank/test*.dat
