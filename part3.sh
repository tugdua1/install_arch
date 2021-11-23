#!/bin/bash
useradd theo
passwd theo <<EOF
password
password
EOF
groupadd sudo
gpasswd -a theo sudo
pacman -S gnome gnome-extra
