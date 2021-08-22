#!/bin/sh
sudo apt update
sudo apt -yf dist-upgrade
sudo apt-get -y --purge autoremove
sudo apt-get autoclean
sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist;"
sh /home/pi/alsyundawy/adlists-updater.sh
sh /home/pi/alsyundawy/pihole-trustpositif.sh
pihole -g -up
pihole -up
