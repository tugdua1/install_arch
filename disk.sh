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
