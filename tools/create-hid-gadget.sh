#!/bin/bash -xe

MANUFACTURER="Solo"
SERIAL="1234567890"
IDVENDOR="0x0483"
IDPRODUCT="0xa2ca"
PRODUCT="Solo Software Authenticator"
CONFIGFS=/sys/kernel/config

modprobe libcomposite
modprobe dummy_hcd
set +e
mount none $CONFIGFS -t configfs
set -e
mkdir -p $CONFIGFS/usb_gadget/fido2
cd $CONFIGFS/usb_gadget/fido2
mkdir -p configs/c.1
mkdir -p functions/hid.usb0
echo 0 > functions/hid.usb0/protocol
echo 0 > functions/hid.usb0/subclass
echo 64 > functions/hid.usb0/report_length
echo -ne "\x06\xd0\xf1\x09\x01\xa1\x01\x09\x20\x15\x00\x26\xff\x00\x75\x08\x95\x40\x81\x02\x09\x21\x15\x00\x26\xff\x00\x75\x08\x95\x40\x91\x02\xc0" > functions/hid.usb0/report_desc
mkdir strings/0x409
mkdir configs/c.1/strings/0x409
echo $IDPRODUCT > idProduct
echo $IDVENDOR > idVendor
echo $SERIAL > strings/0x409/serialnumber
echo $MANUFACTURER > strings/0x409/manufacturer
echo $PRODUCT > strings/0x409/product
echo "Configuration 1" > configs/c.1/strings/0x409/configuration
echo 120 > configs/c.1/MaxPower
ln -s functions/hid.usb0 configs/c.1
echo "dummy_udc.0" > UDC
