#!/bin/bash
pvcreate /dev/sda2
vgcreate ArchVol /dev/sda2
lvcreate -L 2G ArchVol -n ArchRacine
lvcreate -l 100%FREE ArchVol -n ArchHome
mkfs.fat -F 32 /dev/sda1
mkfs.xfs /dev/ArchVol/ArchRacine
mkfs.xfs /dev/ArchVol/ArchHome
