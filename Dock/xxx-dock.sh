#!/bin/bash

DOCKUTIL=/usr/local/bin/dockutil

SLEEP=/bin/sleep

$DOCKUTIL --remove all

$SLEEP 2

$DOCKUTIL --add '/Applications/Launchpad.app' --no-restart

$DOCKUTIL --add '/Applications/Slack.app' --no-restart

$DOCKUTIL --add '/Applications/Mail.app' --no-restart

$DOCKUTIL --add '/Applications/Google Chrome.app' --no-restart

$DOCKUTIL --add '/Applications/Daylite.app' --no-restart

$DOCKUTIL --add '/Applications/Numbers.app' --no-restart

$DOCKUTIL --add '/Applications/Keynote.app' --no-restart

$DOCKUTIL --add '/Applications/Microsoft Word.app' --no-restart

$DOCKUTIL --add '/Applications/Microsoft Excel.app' --no-restart

$DOCKUTIL --add '/Applications/Microsoft PowerPoint.app' --no-restart

$DOCKUTIL --add '/Applications/Adobe Acrobat DC/Adobe Acrobat.app' --no-restart

$DOCKUTIL --add '/Applications/1Password 6.app' --no-restart

$DOCKUTIL --add '/Applications/TextExpander.app' --no-restart

$DOCKUTIL --add '/Applications/System Preferences.app' --no-restart

$DOCKUTIL --add '/Applications' --view grid --display folder --no-restart

$DOCKUTIL --add '~/Downloads' --view grid --display folder

