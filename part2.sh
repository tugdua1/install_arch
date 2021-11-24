#!/bin/bash
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
sed -ire 's/#fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
touch /etc/locale.conf
echo "LANG=fr_FR.UTF-8" >> /etc/locale.conf
touch /etc/vconsole.conf
echo "KEYMAP=fr-latin1" >> /etc/vconsole.conf
touch /etc/hostname
echo "archlinuxlvm" >> /etc/hostname
pacman -S dhcpcd <<EOF

EOF
sed -ire 's/block/block lvm2/' /etc/mkinitcpio.conf
sed -ire 's/keyboard/keyboard keymap/' /etc/mkinitcpio.conf
mkinitcpio -p linux
passwd <<EOF
password
password
EOF
#pacman -S grub <<EOF
#
#EOF
#pacman -S efibootmgr <<EOF
#
#EOF
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
