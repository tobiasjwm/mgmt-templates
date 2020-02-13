#!/bin/bash
dockutil=/usr/local/bin/dockutil
$dockutil --remove all --no-restart
$dockutil --add '/Applications/Google Chrome.app' --no-restart
$dockutil --add '/Applications/Safari.app' --no-restart
$dockutil --add '/Applications/Microsoft OneNote.app' --no-restart
$dockutil --add '/Applications/Microsoft PowerPoint.app' --no-restart
$dockutil --add '/Applications/Microsoft Excel.app' --no-restart
$dockutil --add '/Applications/Microsoft Word.app' --no-restart
$dockutil --add '/Applications/Microsoft Outlook.app' --no-restart
$dockutil --add '/Applications/Managed Software Center.app' --no-restart
$dockutil --add '~/Downloads'