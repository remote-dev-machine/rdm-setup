# ArchLinux persistent usb

## Open VirtualBox
- Install VirtualBox and its extension pack on a Windows machine.
- Setup a new Arch Linux VM using an iso downloaded from arch mirrors
- Go to USB settings section of the VM and add a new usb under the USB 3.0 option
- Start the VM

## Installing new ArchLinux on a usb

Follow the steps below to setup partition (source [ArchUSB persistent](https://magyar.urown.cloud/arch-usb.html))

```
Before proceeding, determine the device name of the target USB drive. First, before plugging in the target USB, view the currently available block devices:
+---------
|# lsblk  |
+---------+
Now insert the target flash drive and view the devices again. The newly detected device /dev/sdX is the name of the target USB you will use for further partitioning and formatting. Note that in the device name you will use is literally /dev/sdX where the only thing that changes is the single lowercase letter value of X. Double check that you have the correct device name /dev/sdX, lest you may repartition the internal hard drive of the machine you are on!

First wipe the partitions on the target USB device by typing d at the interactive prompt until no partitions remain:
+--------------------------+
| Command (? for help): d  |
| No partitions            |
+--------------------------+

Create a brand new GUID partition table:
+-------------------------------------------------------+
| Command (? for help): o                               |
| This option deletes all partitions and creates a new  |
| protective MBR.                                       |
| Proceed? (Y/N): y                                     |
+-------------------------------------------------------+

+---------------------------------------------------------+
| Command (? for help): n                                 |
| Partition number (1-128, default 1):                    |
| First sector (34-XXXXXX), default = 64)                 |
| or {+-}size{KMGTP}:                                     |
| Last sector (64-XXXXXX), default = XXXXXX)              |
| or {+-}size{KMGTP}: +10MB                               |
| Current type is 'Linux filesystem'                      |
| Hex code or GUID (L to show codes, Enter = 8300): EF02  |
+---------------------------------------------------------+

Create a 500MB EFI partition:
+---------------------------------------------------------+
| Command (? for help): n                                 |
| Partition number (2-128, default 2):                    |
| First sector (34-XXXXXX), default = YYYY)               |
| or {+-}size{KMGTP}:                                     |
| Last sector (64-XXXXXX), default = XXXXXX)              |
| or {+-}size{KMGTP}: +500MB                              |
| Current type is 'Linux filesystem'                      |
| Hex code or GUID (L to show codes, Enter = 8300): EF00  |
+---------------------------------------------------------+

Finally, allocate the remaining space to the Linux partition:
+----------------------------------------------------+
| Command (? for help): n                            |
| Partition number (3-128, default 3):               |
| First sector (34-XXXXXX), default = YYYY)          |
| or {+-}size{KMGTP}:                                |
| Last sector (64-XXXXXX), default = XXXXXX)         |
| or {+-}size{KMGTP}:                                |
| Current type is 'Linux filesystem'                 |
| Hex code or GUID (L to show codes, Enter = 8300):  |
+----------------------------------------------------+

Double check the new partition table:
+---------------------------+
|# Command (? for help): p  |
+---------------------------+
It should look something like to this:
+-------------------------------------------------------+
| Number  Start       End  Size       Code  Name        |
|    1       64     20543  10.0 MiB   EF02  BIOS boot   |
|    2    20544   1044543  500.0 MiB  EF00  EFI System  |
|    3  1044544  62521310  29.3 GiB   8300  Linux       |
+-------------------------------------------------------+

If it's all good, write it to the USB stick and exit gdisk:
+--------------------------+
| Command (? for help): w  |
+--------------------------+

format
------
View the new block layout of the target USB device:
+------------------+
|# lsblk /dev/sdX  |
+------------------+
You should now have three blocks on your target USB device: a 10MB block /dev/sdX1, a 500MB block /dev/sdX2, and block taking all the remaining memory/dev/sdX3:
+---------------------------------------------+
| NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT  |
| sdX      8:112  1  7.5G  0 disk             |
| ├─sdX1   8:113  1   10M  0 part             |
| ├─sdX2   8:114  1  500M  0 part             |
| └─sdX3   8:115  1   XXG  0 part             |
+---------------------------------------------+

Do not format the /dev/sdX1 block. This is the BIOS/MBR partion.

Format the 500MB EFI system partition with a FAT32 filesystem:
+---------------------------+
|# mkfs.fat -F32 /dev/sdX2  |
+---------------------------+

Format the Linux partition with an ext4 filesystem:
+-----------------------+
|# mkfs.ext4 /dev/sdX3  |
+-----------------------+

Install Base Package Set
========================
Following the Arch Way, this guide intends to install the minimum number of packages necessary to create a portable working Linux system.

mount
-----
Mount the ext4 formatted partition as the root filesystem:
+----------------------------+
|# mkdir -p /mnt/usb         |
|# mount /dev/sdX3 /mnt/usb  |
+----------------------------+
Mount the FAT32 formatted EFI partition to boot:
+---------------------------------+
|# mkdir /mnt/usb/boot            |
|# mount /dev/sdX2 /mnt/usb/boot  |
+---------------------------------+

pacstrap
--------
Download and install the Arch Linux base packages:
+------------------------------------------------+
|# pacstrap /mnt/usb linux linux-firmware base \ |
|:     base-devel nano vi                        |
+------------------------------------------------+

fstab
-----
The fstab is used by Linux systems to correctly mount available disk partitions on bootup. The partitions can be identified in the fstab in several ways, and some install methods still use the standard labels (/dev/...) instead of UUIDs. This would surely be a failure point of an install on a USB stick as the standard assigned labels for removable devices are not consistent on each boot.

Toggle the -U tag to enable UUIDs as fstab source identifiers:
+---------------------------------------------+
|# genfstab -U /mnt/usb > /mnt/usb/etc/fstab  |
+---------------------------------------------+

Check /etc/fstab, in an editor:
+---------------------------+
|# vi /mnt/usb/etc/fstab    |
+---------------------------+

Configure New System
====================
Your USB stick should now contain a persistent Linux system. We still need to configure a few things before it's ready to boot on its own, though.

In addition to the base packages and in the name of ultimate portability, we will also pull and install the required programs to support automatic wired networking, manual wireless networking, all common graphics cards, touchpad input devices, and laptop battery systems. We also need to make some configuration tweaks to ensure that the new system loads support for removable devices before it attempts to access the filesystems, and that it assigns consistent names to network devices regardless of the machine it is boot up on.

chroot
------
Begin by chrooting into the new system. Besides the final network settings, everything can be set within the chroot environment:
+------------------------+
|# arch-chroot /mnt/usb  |
+------------------------+

locale
------
Use tab-completion to discover your appropriate entries for your region and city:
+---------------------------------------------------------+
|# ln -sf /usr/share/zoneinfo/region/city /etc/localtime  |
+---------------------------------------------------------+
Generate /etc/adjtime:
+---------------------+
|# hwclock --systohc  |
+---------------------+

Edit /etc/locale.gen and uncomment your desired language:
+------------------------+
|# vi /etc/locale.gen    |
+------------------------+
(for US English, uncomment en_US.UTF-8 UTF-8)

Generate the locale information:
+--------------+
|# locale-gen  |
+--------------+
Set the LANG variable in /etc/locale.conf:
+-------------------------------------------+
|# echo LANG=localeline > /etc/locale.conf  |
+-------------------------------------------+
(for US English, localeline is en_US.UTF-8)

hostname
--------
Create the /etc/hostname file containing your desired valid hostname on a single line:
+---------------------------------+
|# echo hostname > /etc/hostname  |
+---------------------------------+

Open /etc/hosts in an editor:
+-------------------+
|# vi /etc/hosts    |
+-------------------+
Add the lines:
+------------------------------------------------+
| 127.0.0.1    localhost                         |
| ::1          localhost                         |
| 127.0.1.1    hostname.localdomain    hostname  |
+------------------------------------------------+

RAM disk image
--------------
In order to boot the Linux Kernel persistently off of a USB device, some adjustments may be necessary to the initial RAM disk image. We need to ensure that block device support is properly loaded before any attempt at loading the filesystem. This not always the way a RAM disk image is configured in a generic Linux installation, and I suspect this may one of the failure points in other Linux USB installations out there. To configure a custom RAM disk image, open /etc/mkinitcpio.conf in an editor:
+-----------------------------+
|# vi /etc/mkinitcpio.conf    |
+-----------------------------+
Ensure the block hook comes before the filesystems hook and directly after the udev hook like the following:
+----------------------------------------------------+
| HOOKS=(base udev block filesystems keyboard fsck)  |
+----------------------------------------------------+

Now regenerate the initial RAM disk image with the changes made:
+-----------------------+
|# mkinitcpio -p linux  |
+-----------------------+

journal config
--------------
A default installation of Arch Linux is setup with systemd to continuously journal various information about current processes and write that data to storage on disk. For a persistent bootable installation on a flash memory device, however, we can change some options in journald.conf to enable journal keeping entirely in RAM (thus reducing writes to the flash device). To control where journal data is stored, open /etc/systemd/journald.conf in and editor:
+-----------------------------------+
|# vi /etc/systemd/journald.conf    |
+-----------------------------------+
To switch journal data storage to RAM, set the storage variable to volatile by ensuring the following line is uncommented:
+-------------------+
| Storage=volatile  |
+-------------------+
As an additional precaution, to ensure the operating system doesn't overfill RAM with journal data, set the max-use variable by adding the line:
+-------------------+
| SystemMaxUse=16M  |
+-------------------+

mount options
-------------
Modern filesystems are able to record various metadata (last accessed, last modified, user rights, etc.) about their files. A default filesystem mount generally keeps track of as much as this information as possible. For a persistent bootable operating system on a flash memory device, however, we should limit some of this record keeping in order to reduce writes to the flash device. Using the noatime mount option in fstab will disable the record keeping of file access times: no writes will occur when a file is read, only when it is modified.

To disable record keeping of file access times for the bootable USB, open /etc/fstab in an editor:
+-------------------+
|# vi /etc/fstab    |
+-------------------+
Change the mount options from relatime to noatime.

bootloader
----------
To enable booting the target USB stick in both boot modes, two bootloaders will need to be installed. For ease of installation, we'll install GRUB for both modes.

Install the grub and efibootmgr packages:
+-----------------------------+
|# pacman -S grub efibootmgr  |
+-----------------------------+
View the current block devices to determine the target USB device:
+---------+
|# lsblk  |
+---------+
Note the target USB device name (without any numbers) /dev/sdX.

Setup GRUB for MBR/BIOS booting mode:
+-----------------------------------------------------------------+
|# grub-install --target=i386-pc --boot-directory /boot /dev/sdX  |
+-----------------------------------------------------------------+
Setup GRUB for UEFI booting mode:
+-----------------------------------------------------+
|# grub-install --target=x86_64-efi --efi-directory \ |
|:     /boot --boot-directory /boot --removable       |
+-----------------------------------------------------+

Generate a GRUB configuration:
+----------------------------------------+
|# grub-mkconfig -o /boot/grub/grub.cfg  |
+----------------------------------------+

video drivers
-------------
To support most common GPUs, install all five basic open source video drivers:
+----------------------------------------------------------+
|# pacman -S xf86-video-amdgpu xf86-video-ati \            |
|:    xf86-video-intel xf86-video-nouveau xf86-video-vesa  |
+----------------------------------------------------------+

touchpad support
----------------
Install support for standard notebook touchpads:
+----------------------------------+
|# pacman -S xf86-input-synaptics  |
+----------------------------------+

battery support
---------------
Install support for checking battery charge and state:
+------------------+
|# pacman -S acpi  |
+------------------+

root password
-------------
Set the root password:
+----------+
|# passwd  |
+----------+

user account
------------
Create a new user user:
+-------------------+
|# useradd -m user  |
+-------------------+
Set user password:
+---------------+
|# passwd user  |
+---------------+

Linux isn't meant to be used with root-user privileges all the time. Enable sudo for user by creating a rule in /etc/sudoers.d/:
+------------------------------------------------------+
|# echo 'user ALL=(ALL) ALL' > /etc/sudoers.d/10-user  |
+------------------------------------------------------+

+ See the network manager section below before logging out of chroot

logout
------
Exit of the chroot:
+----------+
|# exit    |
+----------+
Unmount the USB:
+-----------------------------------------+
|# umount /mnt/usb/boot /mnt/usb && sync  |
+-----------------------------------------+
```

Add Networking:
```
Install network manager:
+-----------------------------+
|# pacman -S networkmanager   |
+-----------------------------+

Start network manager service:
+-----------------------------------+
|# systemctl start networkmanager   |
+-----------------------------------+

Enable network manager service:
+-----------------------------------+
|# systemctl enable networkmanager  |
+-----------------------------------+

Connect to a wifi network using TUI:
+---------+
|# nmtui  |
+---------+

```
