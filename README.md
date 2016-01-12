# openmediavault-linux-kernel
The linux kernel compiled for openmediavault NAS os based on vanilla mainline with some patches for amd64 architecture


## Licence
This is not my work, I just compiled it :)

For the licences to this code see:
*Linux Kernel (www.kernel.org) - GNU GPL version 2 
*aufs file system (https://github.com/sfjro/aufs4-standalone/) - GNU GPL version 2

## Disclaimer
I do not take any responsibility for this code nor do I provide support. The content of this repository is provided as is. 
USE THIS AT YOUR OWN RISK. DO NOT USE THIS ON A PRODUCTION SYSTEM. FOR TESTING/EXPERIMENTAL PURPOSE ONLY. 
I do not take any liablity in dataloss, damage, downtime, etc. in any way, shape or form done to your system.

## Contents

* linux kernel with aufs standalone patchset applied: [kernel-dir] (https://github.com/Stoney49th/openmediavault-linux-kernel/tree/master/kernel) -> directory with pre-build amd64 packages [linux-source-dir] (https://github.com/Stoney49th/openmediavault-linux-kernel/tree/master/kernel/linux-src) -> kernel source with config for building on your own
* btrfs-tools version to go alongside the kernel from debian for convenience
* aufs-source: [aufs-source-dir](https://github.com/Stoney49th/openmediavault-linux-kernel/tree/master/aufs4-standalone-aufs4.1)-> aufs source to go with this kernel, as a reference and for completeness if you wish to patch/repatch yourself

## Installing the prebuild packages

Be sure to checkout the tag you want, the master branch might be at an unstable development stage.

1. pull the repository to some location on your NAS
2. cd into /yourPullLocation/kernel
3. hit dpkg -i linux-*.deb
4. Wait until complete
5. Setup the new default boot kernel via OMV-webgui (omvextras required) or do so manually.
6. Add additional kernel boot parameters, for example for docker: see for example [docker-cgroups-memory](https://docs.docker.com/installation/ubuntulinux/#adjust-memory-and-swap-accounting)
7. reboot
8. Check if kernel used with "uname -r"

## Building on your own (advanced)

Be sure to checkout the tag you want, the master branch might be at an unstable development stage.

1. pull the repository
2. remove old packages in /kernel
3. run "make menuconfig" in the linux source directory
4. Customize your settings
4. safe the config
5. run "make -j5 deb-pkg LOCALVERSION=-YOURCUSTOMNAME_amd64 KDEB_PKGVERSION=YOURVERSION"
6. Make sure to increment the PKGVERSION after each run if you want to install the package, so the replacement is smooth with dpkg. Does not need to be changed if you adapt the LOCALVERSION, but this will result in an additional installation, not a replacement by dpkg.
7. One directory up, the packages can be found
8. Install them as needed (the -dbg is really large and usually not needed)
9. Switch kernels, maybe also adapt boot params and reboot

## MISC

* if you experience problems with hibernate, adding "resume=UUID=UUIDOFYOURSWAPPARTITION ro" to the kernel boot params in /etc/default/grub followed by update-grub might help
* More things to follow as they pop up

openmediavault is great! thanks to everybody and especially volker for all the work on this great and open project!!!
