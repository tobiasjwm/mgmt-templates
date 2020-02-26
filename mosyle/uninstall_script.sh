#!/bin/sh

/usr/bin/profiles -R -p com.mosyle.mdm
/bin/rm -f /usr/local/share/REPLACE-mosyle_enrollment.mobileconfig
/usr/sbin/pkgutil --forget com.mosyle.manager.REPLACE-Mosyle_Enrollment
