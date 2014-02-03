### How to use these files

You should be a bit familiar with Vagrant and Oracle RAC,

Download the Vagrantfile, and stagefiles.zip, unzip it and you should end with an structure like:

	Folder
	Folder\Vagrantfile
	Folder\stagefiles
	Folder\stagefiles\*

Then `vagrant up` and the system should download oracle65-2disk.box and fire up the virtual machines.

In the `Vagrantfile` is the url of the `oracle65-2disk.box`, at the moment is on dropbox.

In case you want to see the [vagrant files in dropbox] I am sharing, click on the link, and use the `Download` or `Copy to my Dropbox` option.

1. Review stagefiles/Readme.md for information what files you need to populate (path, and list of Oracle binaries and patches)
1. Review Vagrantfile, as is, the file will just create the boxes and setup all the needed for an sucesfull oracle rac installation.

Around the line 124, you will find:

		#remove the comments if you want a full automated install of rac
		if File.directory?("stagefiles")
		  #node1.vm.provision :shell, :inline => "sh /media/stagefiles/db/unzip.sh"
		  #node1.vm.provision :shell, :inline => "sh /media/stagefiles/db/install_crs_db.sh rac"
		end

If you want a full hands free un-attended oracle rac instalaltion, remove the comment, and leave the files as:

		#remove the comments if you want a full automated install of rac
		if File.directory?("stagefiles")
		  #node1.vm.provision :shell, :inline => "sh /media/stagefiles/db/unzip.sh"
		  #node1.vm.provision :shell, :inline => "sh /media/stagefiles/db/install_crs_db.sh rac"
		end


Some log files are there for reference:

[vagrant_destroy_rac.log](vagrant_destroy_rac.log)

[vagrant_halt_rac.log](vagrant_halt_rac.log)

[vagrant_up_provision_os_prereq_only.log](vagrant_up_provision_os_prereq_only.log)

[vagrant_up_provision_rac.log](vagrant_up_provision_rac.log)

[vagrant files in dropbox]: https://www.dropbox.com/sh/3ks3e34en9bbec9/zjtqkm71RD/vagrant 
