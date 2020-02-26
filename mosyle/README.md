# Systems Manager to Mosyle Transition Installer

This package will remove the Systems Manager profiles on the Mac and then enroll the Mac in Mosyle MDM.

The Makefile needs [The Luggage](https://github.com/unixorn/luggage) to build the package

## Prepare the installer

1. Obtain your Generic Device Enrollment Mobile Config From your Mosyle Account, found under Management > macOS > Enrollment Assistant > A Generic Device > I will manually enroll the devices
2. Rename the file to REPLACE-mosyle_enrollment.mobileconfig where REPLACE is replaced with the client identifier.
3. Place the file inside the mosyle folder
4. Edit the `postinstall` script to have the correct values for the Systems Manager removal marked with "REPLACE" and the mobileconfig file. Reference your Systems Manager installers for the correct values
5. Edit the Makefile to replace client values marked with "REPLACE"
6. In Terminal, `cd` to your build folder
6. Run `make pkg` as root to create the .pkg

You can now use the .pkg to enroll your devices, be sure to have employees approve the MDM enrollment on any devices running macOS 10.13.2+
	
You're done!

## Optional Cool Stuff

The included `installcheck_script.sh` and `uninstall_script.sh` can be modified similar to the above to be added to a Munki manifest to give you idempotence (installcheck) and a removal option (uninstall).

	% makepkginfo --uninstall_script=/path/to/uninstall_script.sh --installcheck_script=/path/to/installcheck_script.sh