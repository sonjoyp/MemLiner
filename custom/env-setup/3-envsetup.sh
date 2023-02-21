#! /bin/bash
# Script 3
# Download the MLNX OFED driver for the Ubuntu 18.04
cd ~
wget https://content.mellanox.com/ofed/MLNX_OFED-4.9-2.2.4.0/MLNX_OFED_LINUX-4.9-2.2.4.0-ubuntu18.04-x86_64.tgz
tar xzf MLNX_OFED_LINUX-4.9-2.2.4.0-ubuntu18.04-x86_64.tgz
cd MLNX_OFED_LINUX-4.9-2.2.4.0-ubuntu18.04-x86_64

#wget https://content.mellanox.com/ofed/MLNX_OFED-4.9-6.0.6.0/MLNX_OFED_LINUX-4.9-6.0.6.0-ubuntu18.04-x86_64.tgz
#tar xzf MLNX_OFED_LINUX-4.9-6.0.6.0-ubuntu18.04-x86_64.tgz
#cd MLNX_OFED_LINUX-4.9-6.0.6.0-ubuntu18.04-x86_64

# Remove the incompatible libraries
sudo apt remove ibverbs-providers:amd64 librdmacm1:amd64 librdmacm-dev:amd64 libibverbs-dev:amd64 libopensm5a libosmvendor4 libosmcomp3 -y
echo "-----------------MLNX OFED driver Installation Started-------------"
# Install the MLNX OFED driver against the kernel 5.4.0
sudo ./mlnxofedinstall --add-kernel-support --without-fw-update
echo "-----------------MLNX OFED driver Installation Completed-------------"
echo "Start firmware update................................................"
cd ~
wget https://dl.dell.com/FOLDER02078742M/1/fw-ConnectX3-rel-2_30_8000-0T483W-FlexBoot-3.4.151_VPI.zip
unzip fw-ConnectX3-rel-2_30_8000-0T483W-FlexBoot-3.4.151_VPI.zip
cd MLNX_OFED_LINUX-4.9-2.2.4.0-ubuntu18.04-x86_64
sudo ./mlnxofedinstall --fw-update-only --fw-image-dir ~
echo "End firmware update................................................"
echo "Start New Drivers"
sudo /etc/init.d/openibd restart

# Starting Services
#sudo /etc/init.d/opensmd stop
sudo systemctl enable openibd
sudo systemctl start  openibd
sudo sed -i 's/# Default-Start: null/# Default-Start: 2 3 4 5/' /etc/init.d/opensmd
sudo /etc/init.d/opensmd stop
sudo systemctl enable opensmd
sudo systemctl start opensmd
echo "Rebooting...."
sudo reboot