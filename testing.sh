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


cat ssd01.csv >> result.txt
cat hdd01.csv >> result.txt
cat ssd02.csv >> result.txt
cat hdd02.csv >> result.txt
cat ssd03.csv >> result.txt
cat hdd03.csv >> result.txt
cat ssd-var.csv >> result.txt