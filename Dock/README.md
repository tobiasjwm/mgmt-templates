# Dock Util Script

## Usage

This repo includes a script template for triggering [dockutil][1] and a [The Luggage][2] Makefile to place the script into the [outset][3] *login-once* folder.

## Changes

The script no longer has a date stamp on it. In our use and since migrating to outset, we find that we do not add to the Dock profile, rather we make sweeping changes. If we replace a script in outset with the same name, outset considers it as having run for existing users (if the previous version had run) and allows it to sit un-run until a new user account is used.


[1]:https://github.com/kcrawford/dockutil
[2]:https://github.com/unixorn/luggage
[3]:https://github.com/chilcote/outset