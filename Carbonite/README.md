# Carbonite Custom Installer

This template is created to build a custom installer for Carbonite mass-deployment using the _directory device integration_ method to apply backup to all company Macs generically. The generated installer itself is non-functional, but allows for the creation of client installers by duplicating the Munki pkginfo file and replacing the **Activation Code** (variable `aCode`) and **Email** (variable `eMail`) with the client's unique items.

You can obtain the GA version of the Carbonite installer by opening a Device Record in the Carbonite Dashboard and clicking **Help activating account**.

To determine the version number, open the pkg in [Suspicious Package](https://mothersruin.com/software/SuspiciousPackage/).

1. Go to All Files tab and select LocalServiceSettings.config.xml
2. Right-click on the file and choose **Open with > BBEdit** (or your editor of choice)
3. Grab the value from the **ClientVersion** key

Once you have your pkg, drop it into the **payload/tmp** folder.

## Building the custom pkg

*To build the pkg, you must have [munkipkg](https://github.com/munki/munki-pkg) installed.*

Before building the pkg, open the **build-info.plist** and update the version number.

Run the following command to build the pkg:

	munkipkg /path/to/project.folder

## Import the pkg into Munki

Run the following command to import the pkg into Munki:

	munkiimport /path/to/project.folder/build/custom_Carbonite-x.x.x.pkg \
	--installcheck_script=/path/to/project.folder/installcheck_script.sh \
	--postinstall_script=/path/to/project.folder/postinstall_script.sh \
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