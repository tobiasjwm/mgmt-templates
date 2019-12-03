This package will remove the Systems Manager profiles on the Mac and then enroll the Mac in Mosyle MDM.

The Makefile needs [The Luggage](https://github.com/unixorn/luggage) to build the package

Ready?

1. Obtain your Generic Device Enrollment Mobile Config From your Mosyle Account, found under Management > macOS > Enrollment Assistant > A Generic Device > I will manually enroll the devices
2. Rename the file to REPLACE-mosyle_enrollment.mobileconfig
3. Place the file inside the mosyle folder
4. edit the `postinstall` script to have the correct values for the Systems Manager removal marked with "REPLACE" and the mobileconfig file. Reference the Systems Manager installers for the correct values
5. edit the Makefile to replace client values marked with "REPLACE"
6. Run "make pkg" to create the .pkg

You can now use the .pkg to enroll your devices, be sure to approve the MDM enrollment on any devices running macOS 10.13.2+
	
You're done.
