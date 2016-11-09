PACKER := $(shell command -v packer)
VBOXMANAGE := $(shell command -v VBoxManage)

ifndef PACKER
$(error "Required binary 'packer' is unavailable in PATH. Please install packer.")
endif

ifndef VBOXMANAGE
$(error "Required binary 'VBoxManage' is unavailable in PATH. Please install VirtualBox.")
endif

# CentOS-6-x86_64-minimal
C6DIR             := c6x64
C6TARGETS         := minimal kernel-ml-epel gui gui-dev-java
C6OVAS            := $(addprefix build/,$(addsuffix .ova,$(addprefix $(C6DIR)-,$(C6TARGETS))))

#C67TEMPLATES       := $(addsuffix .json,$(addprefix $(C67DIR)/,$(C67TARGETS)))
#$(info C67 OVAs: $(C67OVAS))
#$(info C67 Templates: $(C67TEMPLATES))

all: $(C6OVAS)

# This works mostly as expected.
# The problem is I'm not sure how to declare depdencies: gui depends on
# kernel-ml-epel depends on minimal
#
#build/$(C67DIR)-%.ova: $(C67DIR)/%.json build/out
#	packer build $<
#	mv $(subst build,build/out,$@) $@
#	rmdir build/out

build/$(C6DIR)-minimal.ova: $(C6DIR)/minimal.json | build
	packer build $<
	mv $(subst build,build/out,$@) $@
	rmdir build/out

build/$(C6DIR)-kernel-ml-epel.ova: $(C6DIR)/kernel-ml-epel.json build/c6x64-minimal.ova | build
	packer build $<
	mv $(subst build,build/out,$@) $@
	rmdir build/out

build/$(C6DIR)-gui.ova: $(C6DIR)/gui.json build/c6x64-kernel-ml-epel.ova | build
	packer build $<
	mv $(subst build,build/out,$@) $@
	rmdir build/out

build/$(C6DIR)-gui-dev-java.ova: $(C6DIR)/gui-dev-java.json build/c6x64-gui.ova | build
	packer build $<
	mv $(subst build,build/out,$@) $@
	rmdir build/out

clean:
	rm -rf build

build:
	mkdir build

.PHONY: all clean
