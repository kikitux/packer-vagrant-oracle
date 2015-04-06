# packer-make

This is a packer workflow driven by make.

## Main goal:

The goal behind this, is to leverage on make for what he does best, that is check dependencies and rebuild when needed.

A normal packer workflow goes like this:

1. Create a VM
1. Put the iso
1. Create a web server and share kickstart/preseed file
1. Turn on vm
1. Using the console/keyboard tell the installer to pick the response file
1. Profit!, un-attended OS installation

Things start getting complex as the boxes age and in order to keep size to minimum, instead of patching, we recreate the box.

So, for serveral boxes, you have several packer templates (json files), and you need to somehow decide when to rebuild, some/all of the boxes or just the new ones.

## Make for the non-developers (like me)

Enter make!

sample makefile:

```c
hello: hello.c
	gcc -o hello hello.c
```

This simple example is quite interesting.

We have the target `hello` that is a compiled software.
We have the pre-requirement `hello.c`
And we have the command to generate `hello` that is `gcc -o hello hello.c`

So, go to [sample](sample) and have a look to this `sample` project.

On first run, due `hello` program doesn't exist, and the pre-requisite exist, so make have all it need to generate the code, so will execute the code to generate `hello` from `hello.c`

### Having fun with Make:

So, lets tell make we want him take care of our project:

```bash`
$ make
gcc -o hello hello.c
$ make
make: `hello' is up to date.
```

Good stuff, due `hello` wasn't present, make did generate on first run.

On second run, make is telling us the project is `up to date`.

Let's update our source code:

```bash
$ touch hello.c 
$ make
gcc -o hello hello.c
$
```

This is quite cool.

### Make and dependencies

So make take care of following dependencies, and the power of Make doesn't stop there.

This simple project:

```c
hello: hello.c
	gcc -o hello hello.c
```

Can become something like:

```c
hello: hello.c <pre-req2> .. <pre-reqN>
	gcc -o hello hello.c
```

Which is something we will use for packer.

## Simple Makefile for packer

A simple project for packer, require a `Makefile` and a `packer templatefile` and would look like this:

```c
virtualbox.box: packer-template.json <some_external_dependencie.txt>
	packer build packer-template.json
```

Which is pretty simple and make a lot fo sense:
- if the `virtualbox.box` doesn't exist, make will run packer
- if the pre-requirement is updated, Make will regenerate our image.

So far so good.

## Oracle Linux

On this example, I will be using Oracle Linux, you can modify this for any OS you want.

In Oracle Linux, we have a `yum repo` for [kernel], and a `yum repo` for [packages], so you can use this to create a file that make will use as dependencie, if the dependencie gets updated, make will rebuild our vms.

This may sound simple and trivial, but if you have a bunch of boxes in different levels ie `OL7/OL6/OL5` using diferent Oracle Linux Unbreakeable Kernel `uek/uek2/uek3/playground` plus some using the `redhat compatible one` and a bunch of different boxes for task like `minimal`, `nginx`, `docker`, etc.. you get the idea, a lot to track.

So, let's use `Make` for what it does best

```
ol7_uekr3:=$(shell curl -R -I http://public-yum.oracle.com/repo/OracleLinux/OL7/UEKR3/x86_64/repodata -o ol7_uekr3.txt 2>/dev/null)
ol7_latest:=$(shell curl -R -I http://public-yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/repodata -o ol7_latest.txt 2>/dev/null)
```

With this simple code, on each `Make` run, it will generate a file, with the `header` information and the `time stamp` of the last change.

The first time we run `Make` it will run packer and create the boxes, and later, if the `yum repo` packaged get updated, only then, make will kick a rebuild

[kernel](http://public-yum.oracle.com/repo/OracleLinux/OL7/UEKR3/x86_64/repodata)
[packages](http://public-yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/repodata)

## One (1) pass

On first run, `make list` will show us what will be generated:

```bash
$ cd oracle7-1pass/
$ make list
virtualbox/oracle7-docker.box virtualbox/oracle7-latest.box virtualbox/oracle7-nginx.box vmware/oracle7-docker.box vmware/oracle7-latest.box vmware/oracle7-nginx.box
$ 
```

So, we have 2 providers `virtualbox` and `vmware`, and 3 boxes.

On my mac mini with ssd disk the first run was:

```
real    106m46.521s
user    14m23.382s
sys     2m59.531s
```

and if I run `make` again:

```
$ make
make: Nothing to be done for `all'.
$
```

Not bad!

If I want to add a new box, I just copy one of the `packer templates json file` like nginx, and create a new one

```json
    "variables": {
        ...
        "vm_name": "oracle7-httpd",
        ...
    },
    ...
}
```

And update the script part that install the software:

```bash
      "yum install -y httpd mod_ssl"
```

And let's `make` to do the magic:

