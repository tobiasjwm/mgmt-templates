# Carbonite Custom Installer

This template is created to build a custom installer for Carbonite mass-deployment using the _directory device integration_ method to apply backup to all company Macs generically. The generated installer itself is non-functional, but allows for the creation of client installers by duplicating the Munki pkgsinfo file and replacing the **Activation Code** (variable `aCode`) and **Email** (variable `eMail`) with the client's unique items.

To build the pkg, you must have [munkipkg](https://github.com/munki/munki-pkg) installed.

Run the following command to build the pkg:

	munkiimport /Users/Shared/src/mgmt-templates/Carbonite/build/custom_Carbonite-10.3.5.pkg \
	--installcheck_script=/Users/Shared/src/mgmt-templates/Carbonite/installcheck_script.sh \
	--postinstall_script=/Users/Shared/src/mgmt-templates/Carbonite/postinstall_script.sh \
	--minimum_os_version=10.10.5

Don't forget to add an icon so it looks nice in Managed Software Center.

## Templating

Once you have built and imported the custom pkg, make a copy of the pkgsinfo and place it in `templates` at the root of the Munki Repo. for the `name` string, prepend "xxx-". This will be replaced when creating the client's custom installer.

## Using the Template

1. Copy the `xxx-custom_Carbonite-xxx.plist` file from the `templates` folder to the client's folder
2. Add the client's activation code to the variable `aCode`
3. Add the client's device email to the variable `eMail`
4. Replace the **xxx** in the `name` string with the client abbreviation.
5. Save the pkgsinfo.

Don't forget to `makecatalogs` and to add the item to the client manifest.

## Removal

We are not including a removal script in this pkgsinfo as we are using the generic **DCProtect** pkg to apply removals.