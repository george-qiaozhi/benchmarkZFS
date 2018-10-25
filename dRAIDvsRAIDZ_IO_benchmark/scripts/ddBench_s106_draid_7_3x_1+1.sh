# run: ./ddBench.sh &> output/dir 
# benchmarking draid on s106 with following parity setup
# DRAM:	125GB
# Disk: 4TB
# parity ratio 1:1 x 3 + 1 spare using draid1(raid5)

zpool status dpool

# dd 110GB at a time and record MB/s until full, for 11TB pool, take about 100 times

for i in {1..100}
do
dd if=/dev/urandom of=/dpool/`date +%m%d%H%M%S`.dat bs=10M count=11000
done

echo "******dpool status***** " & date +%m-%d-%H-%M:%S
zpool status dpool
df -h
