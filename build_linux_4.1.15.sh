#!/bin/bash

echo "Please choose a custom kernel revision and name, like 1.0.fooMyName. Must start with a number, only '.' and '+' special chars allowed: "
read custom_rev
echo "Will use $custom_rev, resulting in something like linux-4.1.15-amd64-$custom_rev"

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
[ -f ./linux-4.1.15.tar.xz ] && echo "Kernel Archive already downloaded, skipping download..." || wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.1.15.tar.xz

[ -d ./linux-4.1.15 ] && rm -r ./linux-4.1.15 
echo "Extracting source now, this may take a while..."
tar xf linux-4.1.15.tar.xz

#change dir and build
cd ./linux-4.1.15
wget https://github.com/Stoney49th/openmediavault-linux-kernel/raw/master/.config-4.1.15
mv ./.config-4.1.15 ./.config

read -rsp $'\n\nFinished with all download and decompress steps. Will launch menuconfig now. If you dont want to change anything, just exit menuconfig without saving. Please press any key...\n'
make menuconfig
read -rsp $'\n\nFinished with all download and decompress steps. Press any key to start a clean build ...\n'

make-kpkg clean

echo "

Enter number of parallel threads to use (single digit, like 3(dualcore), 4, 5(quadcore), most likely number of logical cores + 1 works best):"
read n_threads
fakeroot make-kpkg -j$n_threads --initrd --append-to-version=-amd64 --revision=$custom_rev kernel_image kernel_headers

cd ..

echo "

Finsihed building...please install the header and image packages manually using: dpkg -i linux-headers-4.1.15-amd64_$custom_rev.deb linux-image-4.1.15-amd64_$custom_rev.deb
Select the new default kernel from omv-extras kernel interface and reboot..."
