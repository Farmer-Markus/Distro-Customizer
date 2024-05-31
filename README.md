# Distro-Customizer

IMPORTANT: <br />
You can only edit the Live/DVD/USB iso of your distro! <br />
For example debian live [iso](https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/). <br />

Requirements: <br />
`xorriso` <br />
`squashfs-tools` <br />
`wget` <br />

     sudo apt-get install xorriso squashfs-tools wget

Usage: <br />
Step 1. Download this Repository. Run: <br /> 

     git clone https://github.com/Farmer-Markus/Distro-Customizer
     cd Distro-Customizer

Step 2. Download your distro you want to customize. In my case [debian](https://www.debian.org/) with the [gnome](https://www.gnome.org/) desktop:  <br />

     wget https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/debian-live-12.5.0-amd64-gnome.iso

Step 3. After downloading the live iso run:  <br />
     
     ./DecompressIso.sh <Your iso>
In my case:

     ./DecompressIso.sh debian-live-12.5.0-amd64-gnome.iso
This should create  a folder named `iso` with the boot stuff of the iso. <br />
It also extracts `filesystem.squashfs` with the linux live system and extracts its content into a folder named `squashfs-root`. <br />
After finishing you can access the live system with:

     sudo chroot squashfs-root
Now you can customize the filesystem like install/remove packages with `apt`. <br />
If you want to build your final distribution run:

     CompressIso.sh
It may asks you to remove old `filesystem.squashfs`. Yust type `y` to replace the original with your new custom filesystem. <br />
It should start compressing your customized linux filesystem. This can take several minutes. <br />
After finishing you can put your custom iso onto an USB device or run it in a virtual machine. <br />

If you have any problems you can open an [issue](https://github.com/Farmer-Markus/Distro-Customizer/issues) or an [request](https://github.com/Farmer-Markus/Distro-Customizer/pulls).

# Based on
https://dev.to/otomato_io/how-to-create-custom-debian-based-iso-4g37
