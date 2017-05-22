#!/bin/bash

#################################################
# run bonnie++ just once
# export result into html file using tool: bon_csv2html
#################################################
# bonnie++ -u root -d /media/zfs/hddpool -f -b -q > hddpool.csv

# bon_csv2html < hddpool.csv > hddpool.html

# echo hddpool DONE... just hdd

#################################################
# run experiment 5 times
# benchmark on different disk each time to avoid overhead or cache effect
#################################################

# for i in {1..5}
# do
# fn="ssdpool-"$i".csv"
# bonnie++ -u root -d /media/zfs/pool -f -b -q > $fn

# fn="hddpool-"$i".csv"
# bonnie++ -u root -d /media/zfs/hddpool -f -b -q > $fn

# fn="ssd01-"$i".csv"
# bonnie++ -u root -d /ssd01 -f -b -q > $fn

# fn="hdd01-"$i".csv"
# bonnie++ -u root -d /hdd01 -f -b -q > $fn

# fn="ssd-var-"$i".csv"
# bonnie++ -u root -d /var -f -b -q > $fn

# fn="hdd02-"$i".csv"
# bonnie++ -u root -d /hdd02 -f -b -q > $fn

# fn="ssd02-"$i".csv"
# bonnie++ -u root -d /ssd02 -f -b -q > $fn
# done

#################################################
# group result by disk media type. eg: ssdpool, ext4 ssd, etc.
#################################################
# for i in {1..5}
# do
# fn="./benchmarkZFS/2nd-round/ssdpool-"$i".csv"
# cat $fn>>result.txt
# done

# for i in {1..5}
# do
# fn="./benchmarkZFS/2nd-round/hddpool-"$i".csv"
# cat $fn>>result.txt
# done

# for i in {1..5}
# do
# fn="./benchmarkZFS/2nd-round/ssd01-"$i".csv"
# cat $fn>>result.txt
# done

# for i in {1..5}
# do
# fn="./benchmarkZFS/2nd-round/hdd01-"$i".csv"
# cat $fn>>result.txt
# done

# for i in {1..5}
# do
# fn="./benchmarkZFS/2nd-round/ssd-var-"$i".csv"
# cat $fn>>result.txt
# done

# for i in {1..5}
# do
# fn="./benchmarkZFS/2nd-round/hdd02-"$i".csv"
# cat $fn>>result.txt
# done

# for i in {1..5}
# do
# fn="./benchmarkZFS/2nd-round/ssd02-"$i".csv"
# cat $fn>>result.txt
# done

#################################################
# benchmark ext4 & zfs on ssd & hdd with different partition/pool size
#################################################


# for i in {1..5}
# do
# bonnie++ -u root -d /ssd01 -f -b -q >> ssd01.csv

# bonnie++ -u root -d /hdd01 -f -b -q >> hdd01.csv

# bonnie++ -u root -d /ssd02 -f -b -q >> ssd02.csv

# bonnie++ -u root -d /hdd02 -f -b -q >> hdd02.csv

# bonnie++ -u root -d /ssd03 -f -b -q >> ssd03.csv 

# bonnie++ -u root -d /hdd03 -f -b -q >> hdd03.csv

# bonnie++ -u root -d /var -f -b -q >> ssd-var.csv
# done


# cat ssd01.csv >> result.txt
# cat hdd01.csv >> result.txt
# cat ssd02.csv >> result.txt
# cat hdd02.csv >> result.txt
# cat ssd03.csv >> result.txt
# cat hdd03.csv >> result.txt
# cat ssd-var.csv >> result.txt


#################################################
# benchmark new intel DC ssd, compare with Samsung SSD
#################################################

# bonnie++ -u root -d /ssd01 -f -b -q >> ssd01.csv

# bonnie++ -u root -d /ssd11 -f -b -q >> ssd11.csv

# bonnie++ -u root -d /ssd02 -f -b -q >> ssd02.csv

# bonnie++ -u root -d /ssd12 -f -b -q >> ssd12.csv

# bonnie++ -u root -d /ssd03 -f -b -q >> ssd03.csv 

# bonnie++ -u root -d /ssd13 -f -b -q >> ssd13.csv

# bonnie++ -u root -d /var -f -b -q >> ssd-var.csv

# bonnie++ -u root -d /media/zfs/dc3 -f -b -q >> intel-ssd.csv

# cat ssd01.csv >> result.txt
# cat ssd11.csv >> result.txt
# cat ssd02.csv >> result.txt
# cat ssd12.csv >> result.txt
# cat ssd03.csv >> result.txt
# cat ssd13.csv >> result.txt
# cat ssd-var.csv >> result.txt
# cat intel-ssd.csv >> result.txt

# #################################################
# # benchmark HDD with mirror and without redundency both 20GB
# #################################################

# bonnie++ -u root -d /hdd01 -f -b -q >> hdd01.csv
# bonnie++ -u root -d /hdd02 -f -b -q >> hdd02.csv
# bonnie++ -u root -d /hdd03 -f -b -q >> hdd03.csv

# cat hdd01.csv >> result.txt
# cat hdd02.csv >> result.txt
# cat hdd03.csv >> result.txt

# #################################################
# # intel ssd with raid0 20G 40G 80G bonnie++ benchmark
# #################################################
for i in {1..5}
do
bonnie++ -u root -d /SSD20G -f -b -q >> SSD20G.csv
sleep 10m
bonnie++ -u root -d /SSD40G -f -b -q >> SSD40G.csv
sleep 10m
bonnie++ -u root -d /SSD80G -f -b -q >> SSD80G.csv
sleep 10m
done
cat SSD20G.csv >> result.txt
cat SSD40G.csv >> result.txt
cat SSD80G.csv >> result.txt

# #################################################
# samsung ssd with raid1 mirror under different number of mirror per pool
# 2 vdev vs 3 vdev
# #################################################
for i in {1..5}
do
bonnie++ -u root -d /raid1-2vdev -f -b -q >> raid1-2vdev.csv
sleep 10m
bonnie++ -u root -d /raid1-3vdev -f -b -q >> raid1-3vdev.csv
sleep 10m
done
cat raid1-2vdev.csv >> result.txt
cat raid1-3vdev.csv >> result.txt
