vagrant-oracle
==============

A list of Vagrant files for oracle products


# Title

Text
Text with links using [Vagrant] and [Puppet].

## Requirements

* [Vagrant] and [VirtualBox] installed.
* At least 4 GB of RAM.

## Installation

* Clone this project:

        $ git clone https://github.com/kgrodzicki/vagrant-ubuntu-osb.git

* Install [vbguest]:

        $ vagrant plugin install vagrant-vbguest

* Download [Text]. Place the file
  `wls1036_generic.jar` in the directory `modules/oracle/files`
  of this project.

* Run `vagrant up` from the base directory of this project. It takes a while..

* Simple 'localDomain' is not installed by puppet automatically. To do so run commands:
  
        $ vagrant ssh
        $ /tmp/install_domain.sh

* To run weblogic server run command:
  
        $ oracle/user_projects/domains/localDomain/startWebLogic.sh

Start browser from host machine: [http://localhost:7001/sbconsole]. User 'weblogic', password 'weblogic1'.

## Troubleshooting
Sometimes installation of domain fails at the first time. In that case run install_domain.sh more than one time :)

[Vagrant]: http://www.vagrantup.com/

[VirtualBox]: https://www.virtualbox.org/

[Puppet]: http://puppetlabs.com/
