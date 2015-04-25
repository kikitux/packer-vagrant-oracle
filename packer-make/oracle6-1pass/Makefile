BUILDER_TYPES = virtualbox
TEMPLATE_FILES := $(wildcard *.json)
BOX_FILENAMES := $(TEMPLATE_FILES:.json=.box)
BOX_FILES := $(foreach builder, $(BUILDER_TYPES), $(foreach box_filename, $(BOX_FILENAMES), $(builder)/$(box_filename)))

PWD := `pwd`

.PHONY: all

all: $(BOX_FILES)

virtualbox/%.box: %.json
	-rm -f $@
	@-mkdir -p $(@D)
	packer build -color=false -only=$(@D) $<

.PHONY: clean
clean:
	-rm -f $(BOX_FILES)
