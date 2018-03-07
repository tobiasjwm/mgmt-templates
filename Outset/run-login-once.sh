#!/bin/bash

#	run-login-once.sh
#	version: 1.0
#	created: 6 Mar 2018
#	author: Tobias Morrison
#
#	This is a solution for running Outset 'login-once' scripts
#	at install time when the app is installed by the user from
#	MSC or Self-Service. Place this in `/usr/local/outset/on-demand/'
#	https://github.com/chilcote/outset/wiki/OnDemand

#	Trigger anything in 'login-once' 
/usr/local/outset/outset --login-once

#	Fail with grace
exit 0