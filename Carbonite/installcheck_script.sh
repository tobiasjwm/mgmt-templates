#!/bin/bash

carbonitePkg=`pkgutil --pkgs | grep DCProtect`

if [ $carbonitePkg == com.dataprotection.DCProtect ] ; then
	echo "Carbonite already installed. Skipping custom install."
	exit 1
else
	echo "Carbonite not installed. Running custom installer."
	exit 0
fi