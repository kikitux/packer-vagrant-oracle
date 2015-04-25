# Makefile

# Inspired from:
# https://github.com/cloudfoundry/warden-test-infrastructure/blob/master/packer/Makefile
# https://github.com/YungSang/fedora-atomic-packer

date:=$(shell date +%y.%m.%d 2>/dev/null | tee date.txt)
ol7_uekr3:=$(shell curl -R -I http://public-yum.oracle.com/repo/OracleLinux/OL7/UEKR3/x86_64/repodata -o ol7_uekr3.txt 2>/dev/null)
ol7_latest:=$(shell curl -R -I http://public-yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/repodata -o ol7_latest.txt 2>/dev/null)

BUILDER_TYPES = virtualbox vmware
TEMPLATE_FILES := $(wildcard *.json)
BOX_FILENAMES := $(TEMPLATE_FILES:.json=.box)
BOX_FILES := $(foreach builder, $(BUILDER_TYPES), $(foreach box_filename, $(BOX_FILENAMES), $(builder)/$(box_filename)))

PWD := `pwd`

.PHONY: all

all: $(BOX_FILES)

# find a mirror from here
# https://wikis.oracle.com/display/oraclelinux/Downloading+Oracle+Linux

# to make local code as much portable possible
# we leverage on packer for iso cache

output-oracle7-ovf-virtualbox/oracle7.ovf: oracle7.iso_json
	@-rm -rf output-oracle7-ovf-virtualbox/
	@-rm -f virtualbox/*.box
	packer build -color=false -only virtualbox oracle7.iso_json

output-oracle7-vmx-vmware/oracle7.vmx: oracle7.iso_json
	@-rm -rf output-oracle7-vmx-vmware/
	@-rm -f vmware/*.box
	packer build -color=false -only vmware oracle7.iso_json

virtualbox/%.box: %.json output-oracle7-ovf-virtualbox/oracle7.ovf ol7_latest.txt ol7_uekr3.txt
	-rm -f $@
	@-mkdir -p $(@D)
	packer build -only=$(@D) $<

vmware/%.box: %.json output-oracle7-vmx-vmware/oracle7.vmx ol7_latest.txt ol7_uekr3.txt
	-rm -f $@
	@-mkdir -p $(@D)
	packer build -only=$(@D) $<

.PHONY: list
list:
	@echo $(BOX_FILES)

test: virtualbox/$(BOX_FILENAMES)
	@vagrant box add -f ol7-test $<
	@pushd test; \
	vagrant destroy -f; \
	vagrant up --provider=virtualbox; \
	echo "-----> /etc/os-release"; \
	vagrant ssh -c "cat /etc/os-release"; \
	echo "-----> /etc/hostname"; \
	vagrant ssh -c "cat /etc/hostname"; \
	vagrant halt ; \
	vagrant destroy -f; \
        popd

clean:
	-rm -f $(BOX_FILES)
	-rm -rf output-*/

.PHONY: test clean
