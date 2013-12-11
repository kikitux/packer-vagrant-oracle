## Packer files

### vagrant-oracle65-btrfs-uek3 

A template to create a oracle linux 6.5 guest, using virtualbox, btrfs as root filesystem and kernel UEK3.

On the following path `vagrant-oracle65-btrfs-uek3/` you will find 2 files.

These 2 files are basic component of a packer template

		oracle65.json
		oracle65_http/ks.cfg

### Basics of packer

I will explain the basic of packer.

* a json template is created
* packer is invoqued to build a machine with all the information included in the json template file

As part of the build, as we are using Oracle Linux (same apply for other EL linux), we will be using a kickstart file that be used to automate the installation

This kickstart file, will be passed to the installation process as argument typed in the command line, from a url address.

As post-installation (os perspective), some task will be performed

* using ssh, packer will connect to the virtual guest
* will install virtualbox additions
* will execute one script (optional)
* will export the virtual guest in vagrant format

All this done automatically from packer with just 1 command


### Basics of vagrant

Once the box have been created by packer, or you have just got a box file from any source, you can:

* import the box file as box template
* create virtual guests from this box image file
* repackage the box template
* package a virtual guest


##This is a detailed step by step play, of what will be done using these 2 small files in this project:

### Kickstart file explanation

todo

### json template file

###Variables defined:

* User root, password root
* Hostname will be vagrant-oracle65
* Swap size of 6000MB (6G)
* Root Filesystem (/) with btrfs

###Template json file, main body:

* A Yum repository will be used during the installation, so the installer will fetch updated RPMs from here.
* Virtualbox will be used as builder (in packer concepts)
* A Virtual Machine of the type Linux Oracle 64 bits will be created
* VirtualBox guest additions will be retrieved from a given path (versus download from internet)
* Vbox Manage will be used to perform some tasks on the virtual machine

		* Video RAM will be adjusted to 32MB
		* Memory of the Virtual Guest will be adjusted to 2GB
		* A 2nd hard disk will be created, 32GB
		* The 2nd hard disk will be connected to the virual machine
		* A 3rd hard disk will be created, 20GB
		* The 3rd hard disk will be connected to the virual machine

* The main disk will be created

		* Using a SATA interface
		* With a size of 16GB

* Headless won't be enforced (a virtualbox console will show up to monitor the installation)
* Oracle Linux iso will be used from a given local path (versus a web url)
* A subdirectory called `oracle65_http` will be shared by packer web server
* Range of ports to be used by the packer webserver will be from `8080` to `8080` (to enforce use only 1 port)
* SSH user, password and TIME OUT are given to packer from variables
* Shutdown command, and shutdown timeout given to packer
* 5 seconds wait time is defined to wait after the boot of the virtual machine, before sending commands to the console
* A list of commands will be typed in the console, in order to automate the build

		* Text installation
		* Kickstart location
		* Variable HOSTNAME will be passed to the installer
		* Variable SWAPSIZE will be passed to the installer
		* Variable ROOTFS will be passed to the installer
		* Variable YUM will be passed to the installer

### Post tasks (after the OS have been built):

* A shell script, included in the json template file will be created and executed (inline script in packer language)

		* Installation of the VirtualBox Guest Additions
		* Creation of vagrant user, and setup of vagrant requirements (ssh key, sudo)
		* Parameter useDNS=no will be setup for sshd daemon (to reduce unwanted wait on ssh connection)


* A post processor will be called, so the guest created can be easily imported in Vagrant

		* as result of this, a box file will be created.


