KERNEL_FULL_VERSION := $(shell uname -r)
KERNEL_VERSION := $(shell uname -r | grep -o "^[^-]*")
KERNEL_MAJOR := $(shell uname -r | cut -d. -f1)
KERNEL_MINOR := $(shell uname -r | cut -d. -f2)
KERNEL_SOURCE_VERSION := $(KERNEL_MAJOR).$(KERNEL_MINOR)

obj-m := dummy_hcd.o
KVERSION := $(shell uname -r)

all: dummy_hcd.c
	$(MAKE) -C /lib/modules/$(KERNEL_FULL_VERSION)/build M=$(PWD) modules

dummy_hcd.c: /usr/src/linux-source-$(KERNEL_SOURCE_VERSION).tar.xz
	tar -xvf $^ linux-source-$(KERNEL_SOURCE_VERSION)/drivers/usb/gadget/udc/dummy_hcd.c
	cp linux-source-$(KERNEL_SOURCE_VERSION)/drivers/usb/gadget/udc/dummy_hcd.c $@

clean:
	$(MAKE) -C /lib/modules/$(KERNEL_FULL_VERSION)/build M=$(PWD) clean
	rm -rf linux-source-$(KERNEL_SOURCE_VERSION)
	rm -f dummy_hcd.c


