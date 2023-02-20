#! /bin/bash
# Script 1
echo "Running Script 1............."
echo "Increasing root directory size...."
sudo fdisk /dev/sda  <<< "d
1
d
2
d
3
d
n
p
1


N
w
"
echo "Done with root partitioning!"
echo "Rebooting...."
sudo reboot