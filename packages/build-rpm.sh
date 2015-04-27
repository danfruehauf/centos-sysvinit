#!/bin/bash

sysvinit_url="http://vault.centos.org/6.5/os/Source/SPackages/sysvinit-2.87-5.dsf.el6.src.rpm"

download_rpm() {
	local url=$1; shift
	local basename=`basename $url`

	test -f $basename || curl -o $basename $url
}

# main
main() {
	local url=$1; shift
	local rpm_basename=`basename $url`

	download_rpm $url && \
		rpmbuild --rebuild $rpm_basename
}

main "$@"
