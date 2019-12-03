include /usr/local/share/luggage/luggage.make

TITLE=REPLACE-Mosyle_Enrollment
PACKAGE_VERSION=1.0
PACKAGE_NAME=${TITLE}-${PACKAGE_VERSION}
REVERSE_DOMAIN=com.mosyle.manager
PAYLOAD=\
	pack-script-postinstall\
	pack-usr-local-share-REPLACE-mosyle_enrollment.mobileconfig

pack-usr-local-share-%: % l_usr_local_share
	@sudo ${INSTALL} -m 755 -g wheel -o root "${<}" ${WORK_D}/usr/local/share