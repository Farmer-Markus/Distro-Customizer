#!/bin/bash

echo "Enter name of your distro:"
read name

isoname="${name// /-}"

if [ -e "iso/casper" ]
   then

	loc="casper"
   else

	loc="live"
fi

if [ -e "iso/$loc/filesystem.squashfs" ]
   then

	echo "Old filesystem.squashfs aleady exists"
	echo "Would you like to delete it? [y/n]"
	read answer
	if [ "$answer" == "y" ]
	   then

		echo "Deleting filesystem.squashfs..."
		rm "filesystem.squashfs"
		rm "iso/live/filesystem.squashfs"
		if [ ! -e "filesystem.squashfs" ] && [ ! -e "iso/live/filesystem.squashfs" ]
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

if [ -e "$isoname.iso" ]
   then

	echo "$isoname.iso aleady exists"
	echo "Would you like to delete it? [y/n]"
	read answer
	if [ "$answer" == "y" ]
	   then

		echo "Deleting $isoname.iso..."
		rm "$isoname.iso"
		if [ ! -e "$isoname.iso" ]
		   then

			echo "$isoname.iso deleted!"
		   else

			echo  "Cannot delete $isoname.iso"
			exit
		fi
	   else
	   	exit
	fi
fi

sudo mksquashfs  squashfs-root/ filesystem.squashfs -comp xz -b 1M -noappend
if [ ! -e "filesystem.squashfs" ]
   then
	echo "Filesystem not created! Aborting"
	exit
fi

cp filesystem.squashfs iso/$loc/
md5sum iso/.disk/info > iso/md5sum.txt
sed -i 's|iso/|./|g' iso/md5sum.txt
xorriso -as mkisofs -r -V "$name" -o $isoname.iso -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot -isohybrid-gpt-basdat -isohybrid-apm-hfsplus -isohybrid-mbr /usr/lib/ISOLINUX/isohdppx.bin iso/boot iso
