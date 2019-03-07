#!/bin/bash -xe

apt install linux-source dkms
mkdir -p /usr/src/dummy_hcd-0.1/
cp gadgetfs/Makefile /usr/src/dummy_hcd-0.1/
cp gadgetfs/dkms.conf /usr/src/dummy_hcd-0.1/
set +e
dkms remove -m dummy_hcd/0.1 --all
set -e
dkms add -m dummy_hcd -v 0.1
dkms build -m dummy_hcd -v 0.1
dkms install -m dummy_hcd -v 0.1
