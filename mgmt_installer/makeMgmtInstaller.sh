#!/bin/bash

#	makeMGMTnstaller
#	version: 0.2
#	created: 18 Dec 2019
#	author: Tobias Morrison
#
#	Creates a signed combo Watchman and Gruntwork installer.

## Make sure script is run by root ##
if [[ $EUID -ne 0 ]]; then
    echo "Script must be run as root" 1>&2
    exit 1
fi

##  Make sure we are running commands in the same directory as the script  ##
echo "You must run this script for the directory in which it is located."
/usr/bin/cd "$(dirname "$0")"

## Ask the user for a company name and create a variable ##
echo -n "Enter the full company name: "
read clientName

#  Remove all special characters  #
normName() { # clientName
	echo "$1" | sed "s/[^[:alpha:]]/ /g" | sed "s/  */ /g"
}

#  Use sed to remove all spaces and lowercase letters  #
makeAbbr() { # mgmtClient
	echo "$1" | sed 's/[a-z][ ]*//g'
}

#  Create a normalized client name  #
mgmtClient=`normName "$clientName"`
#  Create the client abbreviation  #
clientAbbr=`makeAbbr "$mgmtClient"`

#  tmp working directory variables #
tmpDir="/tmp/mgmtPkg"
#  tmp scripts directory
scriptsDir=""$tmpDir"/Scripts"
#  unsigned package output path  #
outputPath=""$tmpDir"/$clientAbbr-unsignedPkg.pkg"
# signed package output path
signedOutputPath="./$clientAbbr-Management.pkg"
# final zipped output path
zippedOutput="./$clientAbbr-Management-`date "+%Y-%m"`.zip"

# Create a Scripts directory

##  Create a Watchman install script  ##
echo "Building preinstall script."
/bin/mkdir -p "$scriptsDir" 2>/dev/null
echo '#!/bin/bash' > "$scriptsDir"/postinstall
echo "/usr/bin/defaults write /Library/MonitoringClient/ClientSettings ClientGroup -string \"$mgmtClient\"" >> "$scriptsDir"/postinstall
echo "/usr/bin/curl -L1 https://globalmacit.monitoringclient.com/downloads/MonitoringClient.pkg > /tmp/MonitoringClient.pkg" >> "$scriptsDir"/postinstall
echo "/usr/sbin/installer -pkg /tmp/MonitoringClient.pkg -target /"  >> "$scriptsDir"/postinstall
/bin/chmod a+x "$scriptsDir"/postinstall
if [ $? -ne 0 ]; then
	echo "Unable to create the postinstall script."
	exit 2
fi

# Build the Watchman pkg
echo "Building management package."
/usr/bin/pkgbuild --identifier com.globalmacit.pkg.wmInstall --nopayload --scripts "$scriptsDir" ""$tmpDir"/1wmInstall.pkg"
if [ $? -ne 0 ]; then
	echo "Problem building the WM package."
	exit 3
fi

## Create the metapkg
/usr/bin/productbuild --package ""$tmpDir"/1wmInstall.pkg" --package ./maintenance.pkg "$outputPath"
if [ $? -ne 0 ]; then
	echo "Problem building the metapkg package."
	exit 4
fi

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
	# Show me the money
	/usr/bin/open .
	#  Clean up #
	/bin/rm -rf "$tmpDir"
fi