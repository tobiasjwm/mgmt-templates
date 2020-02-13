# office_dock

This is all personal notes. Scripts will not run in your environment unless you magically use the same paths I do. 

This is an OnDemand item for Munki to modify the Dock. it is intended to be used in Self-Service by techs and end-users in environments where Microsoft Office rules the day.

## Process

This simple script allows a user to create a clean Dock. It requires dockutil. Because it uses Munki's OnDemand key, it can be run as often as one likes, including by multiple user accounts on a single Mac.

## Create the plist

Start with the following:

	% makepkginfo -f \
	--description="This on-demand action will remove all items from your Dock and add Google Chrome, Safari, the Microsoft Office Suite and Managed Software Center. The action can be run as many times as you need." \
	--postinstall_script="~/Documents/github/mgmt-templates/dockutil/office_dock/office_dock.sh"

Then add the OnDemand key:

	<key>OnDemand</key>
	<true/>

It is **Super important** to include the requires key:

	<key>requires</key>
	<array>
		<string>dockutil</string>
	</array>

Give it a display name:

	<key>display_name</key>
	<string>Office Dock</string>
	
Give it a name:

	<key>name</key>
	<string>office_dock</string>

Give it an installer type:

    <key>installer_type</key>
    <string>nopkg</string>

Give it a minimum version:

	<key>minimum_os_version</key>
	<string>10.12.0</string>

Categories are nice:

	<key>category</key>
	<string>Self Service</string>

Then give yourself some credit:

	<key>developer</key>
	<string>Tobias Morrison</string>