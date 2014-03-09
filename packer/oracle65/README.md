###

These packer files require 2 Oracle Linux isos to be downloaded and should be on the same folder of these files

To download the isos, I suggest check the mirror on the [Oracle Linux Wiki](https://wikis.oracle.com/display/oraclelinux/Downloading+Oracle+Linux)

		x86_64-boot-uek.iso
		OracleLinux-R6-U5-Server-x86_64-dvd.iso

The first iso `x86_64-boot-uek.iso` is a modified boot.iso that include the `install.img` file that allow install the root filesystem `/` as btrfs.

The second iso `OracleLinux-R6-U5-Server-x86_64-dvd.iso` is the standard Oracle Linux 6.5 x86_64 iso.



### Basics of packer

* a json template is created
* packer is called to build a machine with all the information included in the json template file

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

### Packer files

		packer-oracle65-btrfs.json
		packer-vagrant-oracle65-btrfs-4disk.json
		packer-vagrant-oracle65-btrfs.json

A packer template file to create a oracle linux 6.5 guest, using virtualbox, btrfs as root filesystem and kernel UEK3.

`packer-oracle65-btrfs.json`			Packer file, that will create a guest without vagrant integration.
`packer-vagrant-oracle65-btrfs-4disk.json`	Packer file, that will create a guest, with vagrant integration and 4 disks in total.
`packer-vagrant-oracle65-btrfs.json`		Packer file, that will create a guest, with vagrant integration and 2 disks in total.

### Kickstart file explanation

todo

### json template file

Variables defined:

		$ head -n 17 packer/packer-vagrant-oracle65-btrfs.json
		{
		    "variables": {
		        "ssh_name": "root",
		        "ssh_pass": "root",
		        "hostname": "vagrant-oracle65",
		        "outputfile": "oracle65.box",
		        "rootfs"  : "btrfs",
		        "swapsize": "6000",
		        "harddisk2_size": "32000",
		        "yumurl"     : "http://192.168.56.1/stage/repo/OracleLinux/OL6/latest/x86_64",
		        "repofile"   : "http://192.168.56.1/stage/vbox-yum-ol6.repo",
		        "compression" : 6,
		        "vagrantfile": "Vagrantfile"
		    },

###Template json file, main body:

* A Yum repository will be used during the installation, so the installer will fetch updated RPMs from here.
* Virtualbox will be used as builder (in packer concepts)
* A Virtual Machine of the type Linux Oracle 64 bits will be created
* VirtualBox guest additions will be retrieved from a given path (versus download from internet)
* Vbox Manage will be used to perform some tasks on the virtual machine

		* Video RAM will be adjusted to 32MB
		* Memory of the Virtual Guest will be adjusted
		* A 2nd hard disk will be created
		* The 2nd hard disk will be connected to the virual machine
		* A 3rd hard disk will be created
		* The 3rd hard disk will be connected to the virual machine

* The main disk will be created

		* Using a SATA interface

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


