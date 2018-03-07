#!/bin/bash

# munki post-install script to clean-up old dockutil scrpts
# in /Library/Management/scriptRunner/once/

find "$3"/Library/Management/scriptRunner/once -iname "dock-*.*" -delete