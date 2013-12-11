#packer-vagrant-oracle
==============

A list of Packer and Vagrant files for oracle products.

This is work in progress, and I will be updating this page.


## Why YAPOV page?

This is a Yet Abother Packer or Vagrant page.

After checking around what's available, just found examples and machines related to other EL or debian/ubuntu linux.

This collection of files will be focused on [Oracle Linux], Oracle [VirtualBox] as main base products.

On top of these products, will be integrating scripts to deploy Oracle Clusterware, Oracle Asm, Oracle Database and other products.

## Requirements

For quick start:

* [Vagrant] installed
* [VirtualBox] installed
* At least 4 GB of RAM

For custom build:

* [Packer] installed
* [Vagrant] installed
* [VirtualBox] installed
* [OracleLinux ISO] available

## Installation

* Clone this project:

        $ git clone https://github.com/kikitux/packer-vagrant-oracle.git
        
* Or download this [project] as zip file


## Getting Started

For the impatient one, please skip to Vagrant section to get a environment up and running in no time.

### Oracle Linux ISO files

[ol iso in dropbox]

### Packer

### Vagrant

1. In order to have a quick environment, I have share some [vagrant files in dropbox]

- Download any of the <name>.box

- Add the box into vagrant with 

	$ vagrant box add oracle65 </path/to/the/downloaded/file>

- Verify the machine was imported correctly

	$ vagrant box list

- In a new directory, intialize the image

	$ vagrant init oracle65

- Run `vagrant up` from the base directory of this project. It takes a while..

- Ready to use

2. Customization the `Vagrantfile`



## Troubleshooting

[Vagrant]: http://www.vagrantup.com/

[Packer]: http://packer.io/

[VirtualBox]: https://www.virtualbox.org/

[vagrant files in dropbox]: https://www.dropbox.com/sh/3ks3e34en9bbec9/zjtqkm71RD/vagrant 

[dropbox]: https://www.dropbox.com/sh/3ks3e34en9bbec9/vf_s1n0Pps

[Oracle Linux]: https://linux.oracle.com/

[Oracle Linux Wiki]: https://wikis.oracle.com/display/oraclelinux/Home/

[ol iso in dropbox]: https://www.dropbox.com/sh/jsb3y18z4ebbowa/Z3qVA6JDC-

[Text]: http://link/


[project]: https://github.com/kikitux/packer-vagrant-oracle/archive/master.zip
