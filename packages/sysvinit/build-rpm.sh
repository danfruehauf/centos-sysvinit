#!/bin/bash

set -e

tmp_src_rpm="$PWD/sysvinit-2.87-5.dsf.el6.src.rpm"
test -f $tmp_src_rpm || curl -L -o $tmp_src_rpm http://vault.centos.org/6.5/os/Source/SPackages/sysvinit-2.87-5.dsf.el6.src.rpm

tmp_dir=`mktemp -d`
(cd $tmp_dir && rpm2cpio $tmp_src_rpm | cpio -ivdm)
rm -f $tmp_dir/*.spec # remove spec file

cp -a $tmp_dir/* ~/rpmbuild/SOURCES/
cp -a SOURCES/* ~/rpmbuild/SOURCES/

rm -f $tmp_dir/*; rmdir $tmp_dir

rpmbuild -bb sysvinit.spec
