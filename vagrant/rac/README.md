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

* Review stagefiles/Readme.md for information on what files you need to populate (path, and list of Oracle binaries and patches)
Note: At the moment of this writing, we are using 12.1.0.1, Opatch 12.1.0.1.2, Jan 2014 CPU/PSU for both Grid and Database.

	$ cat stagefiles/db/zip/required_files.txt

		linuxamd64_12c_database_1of2.zip

		linuxamd64_12c_database_2of2.zip

		linuxamd64_12c_grid_1of2.zip

		linuxamd64_12c_grid_2of2.zip

		p6880880_121010_Linux-x86-64.zip

		p17735306_121010_Linux-x86-64.zip
			
### Just os or full rac

* Review Vagrantfile, as is, the file will just create the boxes and setup all the needed for an sucesfull oracle rac installation.

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

### My stagefiles project

The stagefiles included here, are a zip file of other project that I have on github.

If you will like to have a newer set of scripts, go to my github project [kikitux/stagefiles](http://github.com/kikitux/stagefiles) at the moment the scripts have no much description/documentation, but they have a name that should tell you what the intention is.

I will be updating, documenting that project, so bookmark the page and came back in the near future.


### Some log files are there for reference:

[vagrant_destroy_rac.log](vagrant_destroy_rac.log)

[vagrant_halt_rac.log](vagrant_halt_rac.log)

[vagrant_up_provision_os_prereq_only.log](vagrant_up_provision_os_prereq_only.log)

[vagrant_up_provision_rac.log](vagrant_up_provision_rac.log)

[vagrant files in dropbox]: https://www.dropbox.com/sh/3ks3e34en9bbec9/zjtqkm71RD/vagrant 
