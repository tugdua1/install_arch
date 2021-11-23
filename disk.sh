#!/bin/bash
timedatectl set-ntp true

gdisk /dev/sda <<EOF
n


+256M
ef00
n




w
Y
EOF
pvcreate /dev/sda2
vgcreate ArchVol /dev/sda2
lvcreate -L 2G ArchVol -n ArchRacine
lvcreate -l 100%FREE ArchVol -n ArchHome
mkfs.fat -F 32 /dev/sda1
mkfs.ext4 /dev/ArchVol/ArchRacine
mkfs.ext4 /dev/ArchVol/ArchHome
mount /dev/ArchVol/ArchRacine /mnt
mkdir /mnt/home
mkdir /mnt/boot
mount /dev/ArchVol/ArchHome /mnt/home
mount /dev/sda1 /mnt/boot
sed -ire 's/block/block lvm2/' /etc/mkinitcpio.conf
pacstrap -i /mnt base linux linux-firmware nano xfsprogs lvm2 grub efibootmgr <<EOF


EOF
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
