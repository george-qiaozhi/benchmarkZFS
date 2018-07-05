#!/bin/bash

echo -----creating virtual disk-----
qemu-img create -f qcow2 /media/zfs/pool/0.qcow2 20G
qemu-img create -f qcow2 /media/zfs/pool/1.qcow2 20G

modprobe nbd max_part=63

qemu-nbd -c /dev/nbd0 /media/zfs/pool/0.qcow2
qemu-nbd -c /dev/nbd1 /media/zfs/pool/1.qcow2

echo -----creating zpool-----
zpool create ssdpool /dev/nbd0 /dev/nbd1
zpool status ssdpool