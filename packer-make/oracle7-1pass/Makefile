# Makefile

# Inspired from:
# https://github.com/cloudfoundry/warden-test-infrastructure/blob/master/packer/Makefile
# https://github.com/YungSang/fedora-atomic-packer

date:=$(shell date +%y.%m.%d 2>/dev/null | tee date.txt)
ol7_uekr6:=$(shell curl -R -I http://public-yum.oracle.com/repo/OracleLinux/OL7/UEKR6/x86_64/repodata -o ol7_uekr6.txt 2>/dev/null)
ol7_latest:=$(shell curl -R -I http://public-yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/repodata -o ol7_latest.txt 2>/dev/null)

BUILDER_TYPES = virtualbox vmware
TEMPLATE_FILES := $(wildcard *.json)
BOX_FILENAMES := $(TEMPLATE_FILES:.json=.box)
BOX_FILES := $(foreach builder, $(BUILDER_TYPES), $(foreach box_filename, $(BOX_FILENAMES), $(builder)/$(box_filename)))

PWD := `pwd`

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	        OVFTOOL=ovftool
	endif
	ifeq ($(UNAME_S),Darwin)
	        OVFTOOL="/Applications//VMware Fusion.app/Contents/Library/VMware OVF Tool/ovftool"
	endif

.PHONY: all

all: $(BOX_FILES)

# find a mirror from here
# https://wikis.oracle.com/display/oraclelinux/Downloading+Oracle+Linux

# to make local code as much portable possible
# we leverage on packer for iso cache

virtualbox/%.box: %.json ol7_latest.txt ol7_uekr6.txt
	-rm -f $@
	@-mkdir -p $(@D)
	packer build -color=false -only=$(@D) $<
	mv output-oracle7-latest-ovf-virtualbox/oracle7-latest.ova oracle7-latest-virtualbox.ova

vmware/%.box: %.json ol7_latest.txt ol7_uekr6.txt
	-rm -f $@
	@-mkdir -p $(@D)
	packer build -color=false -only=$(@D) $<
	$(OVFTOOL) output-oracle7-latest-vmx-vmware/oracle7.vmx oracle7-latest-vmware.ova

.PHONY: list
list:
	@echo $(BOX_FILES)

.PHONY: clean
clean:
	-rm -f date.txt  ol7_latest.txt  ol7_uekr6.txt
	-rm -f $(BOX_FILES) oracle7-latest-vmware.ova oracle7-latest-virtualbox.ova 
	-rm -fr output-oracle7-latest-ovf-virtualbox/  output-oracle7-latest-vmx-vmware/
