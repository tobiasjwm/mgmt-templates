#!/bin/sh

# Carbonite automated install and enrollment using directory device integration
## VARIABLES - CHANGE THESE ##
aCode="REPLACE"
eMail="REPLACE"
## Static variables. DO NOT CHANGE ##
pkgPath="$3/tmp/DCProtectInstall.pkg"
minorVers=$(sw_vers -productVersion | awk -F '.' '{print $2}')

# Check the version and move the XML file to / if OS is < 10.15
if [ "$minorVers" -lt 15 ] ; then
	/bin/mv -f "$3/Library/LocalAutoConfig.xml" "$3/LocalAutoConfig.xml"
fi

# Run the installer
/usr/sbin/installer -pkg "$pkgPath" -tgt /

# Run the activation
"$3/Applications/Carbonite Endpoint.app/Contents/DCProtect/DCProtect.app/Contents/MacOS/DCProtect" \
	-autoactivation \
	-activationCode="$aCode" \
	-activationUrl=red-us.mysecuredatavault.com \
	-email="$eMail"

# Clean up
if [ -e "$pkgPath" ]; then
    # pkg is present, remove it
	/bin/rm -rf "$pkgPath"
fi