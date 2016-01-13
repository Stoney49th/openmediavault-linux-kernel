# openmediavault-linux-kernel
The linux kernel and other build scipts for more up to date packages on a openmediavault NAS-OS based on vanilla or debian packages.

I will try to provide working configs and build scripts for the most up-to-date lts kernel, starting from X.X.1 releases while dropping support for the previous lts one starting from x.x.5. Sorry, I cant maintain two kernel-lines at the moment, but feel free to contribute to this repo, I gladly give access for people willing to maintain a given lts kernel line with working .configs and build scripts.

## Disclaimer
I do not take any responsibility for this code nor do I provide support. The content of this repository is provided as is. 
USE THIS AT YOUR OWN RISK. DO NOT USE THIS ON A PRODUCTION SYSTEM. FOR TESTING/EXPERIMENTAL PURPOSE ONLY. 
I do not take any liablity in dataloss, damage, downtime, etc. in any way, shape or form done to your system.

## Using the build scripts

Download the shell scripts, or pull this repo entirely.

1. Run the shell scripts. First, install the new btrfs_tools before using a newer kernel.
2. Install the new kernel as per script instructions
3. Setup the new default boot kernel via OMV-webgui (omvextras required) or do so manually.
4. Add additional kernel boot parameters, for example for docker: see for example [docker-cgroups-memory](https://docs.docker.com/installation/ubuntulinux/#adjust-memory-and-swap-accounting)
5. reboot
6. Check if kernel used with "uname -r"

## MISC / GOTCHAS / ISSUES

* if you experience problems with hibernate, adding "resume=UUID=UUIDOFYOURSWAPPARTITION ro" to the kernel boot params in /etc/default/grub followed by update-grub might help
* More things to follow as they pop up
* Does not contain AUFS, make sure to use a different storage backend in docker, like overlay or btrfs.

openmediavault is great! thanks to everybody and especially volker for all the work on this great and open project!!!
