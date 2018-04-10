#!/bin/bash
#
# Install Password Safe if it is not already installed. This is using the deb from the
# project: https://sourceforge.net/projects/passwordsafe/

# Check if password safe is installed
if ! $(dpkg-query -s pwsafe >/dev/null 2>/dev/null || which pwsafe >/dev/null 2>/dev/null); then
	wget -O ~/Downloads/pwsafe.deb https://cytranet.dl.sourceforge.net/project/passwordsafe/1.04BETA/passwordsafe-ubuntu-1.04.0-BETA.amd64.deb
	if test "$?" != "0"; then
		echo "
[ERROR] Failed to get password safe deb.
[ERROR] Exit Code: $?
"
		exit 1
	fi

	sudo dpkg -i ~/Downloads/pwsafe.deb
	rm -f ~/Downloads/pwsafe.deb
	
	sudo apt -yfq install
	sudo apt -yq update
	sudo apt -yq upgrade
fi

