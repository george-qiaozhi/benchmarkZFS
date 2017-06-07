#check_smart.sh

date >> ../smart_records/ST31000524AS_s211.smart
smartctl -A /dev/sda >> ../smart_records/ST31000524AS_s211.smart
date >> ../smart_records/intelDC3520_1.smart
smartctl -A /dev/sdb >> ../smart_records/intelDC3520_1.smart
date >> ../smart_records/intelDC3520_2.smart
smartctl -A /dev/sdc >> ../smart_records/intelDC3520_2.smart
date >> ../smart_records/intelDC3520_3.smart
smartctl -A /dev/sdd >> ../smart_records/intelDC3520_3.smart
date >> ../smart_records/intelDC3520_4.smart
smartctl -A /dev/sde >> ../smart_records/intelDC3520_4.smart  

