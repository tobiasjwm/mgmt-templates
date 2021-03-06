#!/bin/bash

loggedInUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
dockutil=$(sudo -u "$loggedInUser" /usr/local/bin/dockutil)
minorVers=$(sw_vers -productVersion | awk -F '.' '{print $2}')

"$dockutil" --remove all /Users/"$loggedInUser" --no-restart 
if [ "$minorVers" == 15 ]; then
	"$dockutil" --add '/System/Applications/Launchpad.app' /Users/"$loggedInUser" --no-restart
else
"$dockutil" --add '/Applications/Launchpad.app' /Users/"$loggedInUser" --no-restart
fi

"$dockutil" --add '/Applications/Google Chrome.app' /Users/"$loggedInUser" --no-restart
"$dockutil" --add '/Applications/Safari.app' /Users/"$loggedInUser" --no-restart
"$dockutil" --add '/Applications/Microsoft OneNote.app' /Users/"$loggedInUser" --no-restart
"$dockutil" --add '/Applications/Microsoft PowerPoint.app' /Users/"$loggedInUser" --no-restart
"$dockutil" --add '/Applications/Microsoft Excel.app' /Users/"$loggedInUser" --no-restart
"$dockutil" --add '/Applications/Microsoft Word.app' /Users/"$loggedInUser" --no-restart
"$dockutil" --add '/Applications/Microsoft Outlook.app' /Users/"$loggedInUser" --no-restart
"$dockutil" --add '/Applications/Managed Software Center.app' /Users/"$loggedInUser" --no-restart
"$dockutil" --add '~/Downloads' --display stack /Users/"$loggedInUser"
killall Dock