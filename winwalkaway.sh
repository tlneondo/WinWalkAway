#!/usr/bin/bash

MenuEntry=""

#run as admin
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, use sudo "$0" instead" 1>&2
   exit 1
fi


MenuEntry=$(sudo cat /etc/grub2.cfg | grep "Windows Boot Manager" |  awk -F "[\"']" '/menuentry/ { print $2 }')

if [ -z "$MenuEntry" ]; then
    echo "Windows Boot Manager entry not found in GRUB configuration."
    exit 1
else
    echo "Found Windows Boot Manager entry: $MenuEntry"
fi


sudo grub2-reboot "$MenuEntry"
sudo reboot
