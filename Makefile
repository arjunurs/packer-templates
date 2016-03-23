PACKER := $(shell command -v packer)
VBOXMANAGE := $(shell command -v VBoxManage)

C67DIR = centos-6.7-x86_64-minimal
C67OVAS = o-base/centos-6.7-x86_64-minimal.ova o-kml/kernel-ml-epel.ova o-gui/gui.ova
FPC67OVAS = $(addprefix $(C67DIR)/,$(C67OVAS))

all: prereq $(FPC67OVAS)

$(C67DIR)/o-base/centos-6.7-x86_64-minimal.ova:
	cd $(C67DIR) && packer build base.json

$(C67DIR)/o-kml/kernel-ml-epel.ova: $(C67DIR)/o-base/centos-6.7-x86_64-minimal.ova
	cd $(C67DIR) && packer build kernel-ml-epel.json

$(C67DIR)/o-gui/gui.ova: $(C67DIR)/o-kml/kernel-ml-epel.ova
	cd $(C67DIR) && packer build gui.json

clean:
	find . -type f -name \*.ova -delete
	find . -type d -name o-\* -delete

prereq:
ifndef PACKER
	$(error "Required binary 'packer' is unavailable in PATH. Please install packer.")
endif

ifndef VBOXMANAGE
	$(error "Required binary 'VBoxManage' is unavailable in PATH. Please install VirtualBox.")
endif

.PHONY: all clean prereq
