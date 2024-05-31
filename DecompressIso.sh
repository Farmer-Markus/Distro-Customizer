#!/bin/bash
#https://github.com/Farmer-Markus/Distro-Customizer

if [ "$1" == "" ]
   then

	echo 'Usage:'
	echo '      ./DecompressIso.sh <target.iso>'
	exit
fi

echo "WARNING: This script needs root access to decompress the iso."

if [ -e "iso" ]
   then

	echo "'Iso' already exists"
	exit
   else

	xorriso -osirrox on -indev $1 -extract / iso && chmod -R +w iso
fi

if [ ! -e "iso/.disk" ]
   then

	echo ''
	echo "Failed to extract iso!"
	exit
fi

if [ -e "iso/casper" ]
   then

	cp "iso/casper/filesystem.squashfs" .
   else

	cp "iso/live/filesystem.squashfs" .
fi

if [ -e "squashfs-root" ]
   then

	echo "Old filesystem.squashfs already exists."
	echo "Would you like to delete it? [y/n]"
	read answer
	if [ "$answer" == "y" ]
	   then

		echo "Deleting filesystem.squashfs..."
		rm "filesystem.squashfs"
		if [ ! -e "filesystem.squashfs" ]
		   then

			echo "filesystem.squashfs deleted!"
		   else

			echo  "Cannot delete filesystem.squashfs"
			exit
		fi
	   else

		exit
	fi
fi
		
sudo unsquashfs "filesystem.squashfs"

if [ ! -e "squashfs-root" ]
   then

	echo "Failed to unpack squashfs filesystem"
	exit
fi

echo "Now you can access the Linux filesystem with 'sudo chroot squashfs-root'"
