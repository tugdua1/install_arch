#!/bin/bash
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc
sed -ire 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=fr-latin1" >> /etc/vconsole.conf
echo "virtualtgdl" >> /etc/hostname
echo -e "password" | passwd
grub-install --target=i386-pc /dev/sda
grub mkconfig -o /boot/grub/grub.cfg