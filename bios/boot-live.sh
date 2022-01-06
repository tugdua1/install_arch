#!/bin/bash
source config.env
loadkeys $KEYMAP

ping wikipedia.org

timedatectl set-ntp true

echo -e "n\np\n\n\n+1G\nn\np\n\n\n\nw\n" | fdisk /dev/sda

mkswap /dev/sda1
mkfs.ext4 /dev/sda2

swapon /dev/sda1
mount /dev/sda2 /mnt

#mkdir /mnt/home

pacstrap -y /mnt base linux linux-firmware devtools vim man-pages grub

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt