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
mkfs.xfs /dev/ArchVol/ArchRacine
mkfs.xfs /dev/ArchVol/ArchHome
mount /dev/archVol/ArchRacine /mnt
mkdir /mnt/home
mkdir /mnt/boot
mount /dev/archVol/ArchHome /mnt/home
mount /dev/sda1 /mnt/boot
sed -ire 's/block/block lvm2/' /etc/mkinitcpio.conf
pacstrap -i /mnt base linux linux-firmware nano xfsprogs lvm2
genfstab -U /mnt >> /mnt/etc/fstab
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
pacman -S dhcpcd
mkinitcpio -p linux
passwd <<EOF
password
password
EOF
pacman -Sy grub
pacman -Sy efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
exit
reboot
