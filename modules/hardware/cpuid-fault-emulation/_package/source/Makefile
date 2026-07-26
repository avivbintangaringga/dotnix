obj-m += cpuid_fault_emulation.o
cpuid_fault_emulation-y := src/cpuid_fault_emulation.o src/capture_context.o src/run_vm.o

PWD := $(CURDIR)
ccflags-y += -I$(src)/inc
asflags-y += -I$(src)/inc


NOCLANG := CONFIG_CLANG_VERSION=0

KERNEL := $(if $(KERNEL),$(KERNEL),$(shell uname -r))

# KDIR can be overridden (e.g. by Nix, pointing into the store) instead of
# assuming the FHS path /lib/modules/$(KERNEL)/build exists.
KDIR ?= /lib/modules/$(KERNEL)/build

ifneq ($(shell grep "CONFIG_CLANG_VERSION" $(KDIR)/.config), $(NOCLANG))
	LLVM := LLVM=1
endif


all:
	echo $(MAKE) $(LLVM) -C $(KDIR) M=$(PWD) modules
	$(MAKE) $(LLVM) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
