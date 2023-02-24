#! /bin/bash
# Script 4 - Only for CPU server
cd ~
sudo apt update
echo Y | sudo apt install python-pip
sudo pip install gdown
gdown https://drive.google.com/uc?id=1-KOdc2NrquiA5vLk5b-f0Eua8hfM9IWO
tar zxvf jdk-12.0.2_linux-x64_bin.tar.gz
echo Y | sudo apt install g++-5
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 0
echo Y | sudo apt-get install libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev
echo Y | sudo apt-get install libcups2-dev
echo Y | sudo apt-get install libfontconfig1-dev
echo Y | sudo apt-get install libasound2-dev
cd ${HOME}/MemLiner/JDK
./configure --with-boot-jdk=$HOME/jdk-12.0.2 --with-debug-level=release
make JOBS=32
echo "Installing java is done!!!!"
echo "Rebooting..."
sudo reboot