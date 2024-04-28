#!/bin/sh
mkdir -p /mnt/gamecart/$1
mount $1 /mnt/gamecart/$1
echo $1 $? >> /tmp/udev_test.log
#umount $1
