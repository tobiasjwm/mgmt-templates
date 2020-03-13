#!/bin/sh
# sanity check to prevent custom install over existing installation.
if [ -f "/Library/LaunchDaemons/com.dataprotection.protectionservice.plist" ]; then
	echo "Carbonite already installed. Skipping custom install."
	exit 1
else
	echo "Carbonite not installed. Running custom installer."
	exit 0
fi