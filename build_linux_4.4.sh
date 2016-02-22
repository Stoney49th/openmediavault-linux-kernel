#!/bin/bash

echo "Please enter the linux-subversion to download. It will be result in a version string like 4.4.YOURINPUT.
So you just have to enter the last digit of the current latest 4.4 stable/longterm version found on kernel.org (e.g. 2,3,4 or newer :) ):"
read uin_subver

linux_version=4.4.$uin_subver
echo "
--------------------------------------------------------------------------
Will try to download and compile linux-$linux_version as you've specified.
--------------------------------------------------------------------------
"

echo "Please choose a custom kernel revision and name, like 1.0.fooMyName. Must start with a number, only '.' and '+' special chars allowed: "
read custom_rev
echo "Will use $custom_rev, resulting in something like linux-4.4.XX-amd64-$custom_rev"

echo "
***************************************
	Prerequs
***************************************
"
#install prerequisites
yes "" | apt-get install git fakeroot build-essential ncurses-dev xz-utils bc
yes "" | apt-get --no-install-recommends install kernel-package

#create directory and download
mkdir kernelbuild
cd ./kernelbuild
echo "
***************************************
	Downloading and Decompressing Source
***************************************
"
[ -f ./linux-$linux_version.tar.xz ] && echo "Kernel Archive already downloaded, skipping download..." || wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-$linux_version.tar.xz

[ -d ./linux-$linux_version ] && rm -r ./linux-$linux_version 
echo "Extracting source now, this may take a while..."
tar xf linux-$linux_version.tar.xz

#change dir and build
cd ./linux-$linux_version
wget https://github.com/Stoney49th/openmediavault-linux-kernel/raw/master/.config-4.4.1
mv ./.config-4.4.1 ./.config

read -rsp $'\n\nFinished with all download and decompress steps. Will launch oldconfig, followed by menuconfig now.\nGoogle up on oldconfig to see how this works, just in case a maintenance fix resultet in a new config option.\nIf you dont want to change anything, just exit menuconfig without saving. Please press any key...\n'
make oldconfig
make menuconfig
read -rsp $'\n\nFinished with all download and decompress steps. Press any key to start a clean build ...\n'

make-kpkg clean

echo "

Enter number of parallel threads to use (single digit, like 3(dualcore), 4, 5(quadcore), most likely number of logical cores + 1 works best):"
read n_threads
fakeroot make-kpkg -j$n_threads --initrd --append-to-version=-amd64 --revision=$custom_rev kernel_image kernel_headers

cd ..

echo "

Finsihed building...please install the header and image packages manually using: dpkg -i linux-headers-4.4.1-amd64_$custom_rev.deb linux-image-4.4.1-amd64_$custom_rev.deb
Select the new default kernel from omv-extras kernel interface and reboot..."
