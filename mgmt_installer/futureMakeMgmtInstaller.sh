#!/bin/bash

#	makeMgmtInstaller.sh
#	version: 0.1
#	created: 12 Dec 2019
#	author: Tobias Morrison
#
#	Creates a signed GlobalMac IT Management Tools and Watchman installer.
#
#   Script requires that your management installer reside in the same directory as this script.
#   Rename your management package "maintenance.pkg" and place it in this directory.

##  Make sure script is run by root  ##
if [[ $EUID -ne 0 ]]; then
    echo "Script must be run as root" 1>&2
    exit 1
fi

##  Make sure we are running commands in the same directory as the script  ##
/usr/bin/cd "$(dirname "$0")"

## Ask the user for a company name and create a variable ##
echo -n "Enter the full company name: "
read mgmtClient

# Use sed to remove all spaces and lowercase letters
makeAbbr() { # mgmtClient
	echo "$1" | sed 's/[a-z][ ]*//g'
}

#  Create the client abbreviation  #
clientAbbr=`makeAbbr "$mgmtClient"`

# Create a tmp working directory #
tmpDir="/tmp/mgmtPkg"

##  Create a Watchman install script  ##
echo "Building preinstall script."
/bin/mkdir "$tmpDir" 2>/dev/null
echo '#!/bin/bash' > "$tmpDir"/preinstall
echo "/usr/bin/defaults write /Library/MonitoringClient/ClientSettings ClientGroup -string \"$mgmtClient\"" >> "$tmpDir"/preinstall
echo "/usr/bin/curl -L1 https://globalmacit.monitoringclient.com/downloads/MonitoringClient.pkg > /tmp/MonitoringClient.pkg" >> "$tmpDir"/preinstall
echo "/usr/sbin/installer -pkg /tmp/MonitoringClient.pkg -target /"  >> "$tmpDir"/preinstall
/bin/chmod a+x "$tmpDir"/preinstall
if [ $? -ne 0 ]; then
	echo "Unable to create the preinstall script."
	exit 2
fi

# Expand the management installer ##
echo "Expanding management package."
/usr/sbin/pkgutil --expand ./maintenance.pkg "$tmpDir"/maintenance-expanded

# Copy the preinstall script into our expanded folder
echo "Copying preinstall script."
/bin/cp "$tmpDir"/preinstall "$tmpDir"/maintenance-expanded/Scripts/preinstall
if [ $? -ne 0 ]; then
	echo "Problem copying the preinstall script."
	exit 3
fi

#  unsigned package output path  #
outputPath=""$tmpDir"/$clientAbbr-unsignedPkg.pkg"

#  Flatten the package  #
echo "Building management package."
/usr/sbin/pkgutil --flatten "$tmpDir"/maintenance-expanded "$outputPath"
if [ $? -ne 0 ]; then
	echo "Problem building the management package."
	exit 4
fi

##  Sign the package and zip it for delivery  ##
# signed package output path
signedOutputPath="./$clientAbbr-Management.pkg"
# final zipped output path
zippedOutput="./$clientAbbr-Management-`date "+%Y-%m"`.zip"

# Sign the pkg
echo "Signing Installer."
productsign --sign "Developer ID Installer: Tobias Morrison (LCXGBRS4V3)" "$outputPath" "$signedOutputPath"
/bin/sleep 5 # productsign needs some time to run
if [ $? -ne 0 ]; then
	echo "Problem signing the package."
	exit 5
fi
/usr/bin/zip "$zippedOutput" "$clientAbbr-Management.pkg"
if [ $? -ne 0 ]; then
	echo "Problem compressing package."
	exit 6
else
	echo "Success! Your combo installer pkg is done: $zippedOutput"
	/usr/bin/open .
	#  Clean up #
	/bin/rm -rf "$tmpDir"
fi