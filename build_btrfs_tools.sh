#!/bin/bash

#install prerequisites
yes "" | apt-get install build-essential debhelper devscripts dh-make quilt fakeroot lintian git
yes "" | apt-get install asciidoc xmlto --no-install-recommends
yes "" | apt-get install uuid-dev libattr1-dev zlib1g-dev libacl1-dev e2fslibs-dev libblkid-dev liblzo2-dev automake pkg-config

#create directory and download
mkdir btrfs-tools
cd ./btrfs-tools
dget -u http://http.debian.net/debian/pool/main/b/btrfs-tools/btrfs-tools_4.3-1.dsc

#build
cd ./btrfs-tools-4.3
dpkg-buildpackage -us -uc
cd ..

#packages ready, install them with dpkg -i 

echo "

Finished...install package manually using: dpkg -i btrfs-tools_4.3-1_amd64.deb

"

#EOF

