PACKER := $(shell command -v packer)
VBOXMANAGE := $(shell command -v VBoxManage)

ifndef PACKER
$(error "Required binary 'packer' is unavailable in PATH. Please install packer.")
endif

ifndef VBOXMANAGE
$(error "Required binary 'VBoxManage' is unavailable in PATH. Please install VirtualBox.")
endif

# CentOS-6.7-x86_64-minimal
C67DIR             := c67x64
C67TARGETS         := minimal kernel-ml-epel gui
C67TEMPLATES       := $(addsuffix .json,$(addprefix $(C67DIR)/,$(C67TARGETS)))
C67OVAS            := $(addprefix build/,$(addsuffix .ova,$(addprefix $(C67DIR)-,$(C67TARGETS))))
$(info C67 OVAs: $(C67OVAS))
$(info C67 Templates: $(C67TEMPLATES))

all: $(C67OVAS)

# This works mostly as expected.
# The problem is I'm not sure how to declare depdencies: gui depends on
# kernel-ml-epel depends on minimal
#
#build/$(C67DIR)-%.ova: $(C67DIR)/%.json build/out
#	packer build $<
#	mv $(subst build,build/out,$@) $@
#	rmdir build/out

build/$(C67DIR)-minimal.ova: $(C67DIR)/minimal.json build
	packer build $<
	mv $(subst build,build/out,$@) $@
	rmdir build/out

build/$(C67DIR)-kernel-ml-epel.ova: $(C67DIR)/kernel-ml-epel.json build/c67x64-minimal.ova build
	packer build $<
	mv $(subst build,build/out,$@) $@
	rmdir build/out

build/$(C67DIR)-gui.ova: $(C67DIR)/gui.json build/c67x64-kernel-ml-epel.ova build
	packer build $<
	mv $(subst build,build/out,$@) $@
	rmdir build/out

clean:
	rm -rf build

build:
	mkdir build

.PHONY: all clean
