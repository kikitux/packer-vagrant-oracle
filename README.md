#packer-vagrant-oracle

A list of Packer and Vagrant files for oracle products.

This is work in progress, and I will be updating this page.

## What's new??

### March-2015, added packer-make 

Check [packer-make] that is a packer workflow driven by make!

### November-2014, racattack-ansible-oracle, Rac with Vagrant and Ansible

The project has his own repo, please go to [github.com/racattack/racattack-ansible-oracle](https://github.com/racattack/racattack-ansible-oracle)

This is a full un-attended zero-to-oracle-rac using vagrant and ansible.

### April-2014, racattack with Vagrant

The project has his own repo, please go to [github.com/racattack/vagrant/file/tree/master/OracleLinux](https://github.com/racattack/vagrantfile/tree/master/OracleLinux)

This is an un-attended VM creation for Oracle RAC, it doesn't install any Oracle Grid/DB software, however it does all the heavy lifting to just run `runInstaller`

### February-2014, added oracle rac made easy with Vagrant !

Check [vagrant/rac], a somewhat scripted rac installation, this was used as base for racattack automation

## Why this project?

This is a Yet Another Packer or Vagrant page.

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
* OracleLinux ISO available

## packer-make

This is a project of Make driven packer build

Please check [packer-make] for instructions and times

# Installation

* Clone this project:

        $ git clone https://github.com/kikitux/packer-vagrant-oracle.git
        
* Or download this [project] as zip file


# Getting Started

For the impatient one, please skip to Vagrant section to get a environment up and running in no time.

## Oracle Linux ISO files

[ol iso in dropbox]

## Packer

## Vagrant


###Customization of the `Vagrantfile`


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

[vagrant/rac]: https://github.com/kikitux/packer-vagrant-oracle/tree/master/vagrant/rac

[packer-make]: https://github.com/kikitux/packer-vagrant-oracle/tree/master/packer-make

[project]: https://github.com/kikitux/packer-vagrant-oracle/archive/master.zip
