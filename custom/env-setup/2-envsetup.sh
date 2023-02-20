#! /bin/bash
# Script 2
echo "Running Script 2...."
#After reboot
sudo resize2fs /dev/sda1

#Git clone
#git clone https://github.com/uclasystem/MemLiner.git

# Build and Install Kernel
cd ~/MemLiner/Kernel
# In case new kernel options are prompted, press enter to use the default options.
echo "-----------------Kernel Build Started----------------------"
echo Y | sudo ./build_kernel.sh build
echo "-----------------Kernel Build Completed--------------------"
echo "-----------------Kernel Installation Started---------------"
echo Y | sudo ./build_kernel.sh install
echo "-----------------Kernel Installation Completed-------------"
echo "Rebooting...."
sudo reboot