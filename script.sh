#!/bin/bash
dnf install -y mdadm
#создаю каталоги для монтирования в них через fstab
mkdir /mnt/disk{1..5}

#создаю GPT разметку и разделы на дисках sdb..sdk
for var in {b..k}
do
parted /dev/sd$var --script mklabel gpt
parted /dev/sd$var --script mkpart primary 1MiB 500MiB
done

#собираю из разделов RAID10 и создаю GPT разметку
mdadm --create /dev/md0 --level 10 -n 10 /dev/sd{b..k}1
parted /dev/md0 --script mklabel gpt
sleep 3

#создаю 5 разделов, каждый из которых составляет 19% объема массива
#форматирую их в ext4
#делаю запись в /etc/fstab
P1=1
for var in {1..5}
do
let P2=$P1+19
parted /dev/md0 --script mkpart primary $P1% $P2% && mkfs.ext4 /dev/md0p$var && echo "UUID=$(blkid -o value /dev/md0p$var | head -1) /mnt/disk$var ext4 defaults 0 0" >> /etc/fstab
P1=$P2
done

mount -a

