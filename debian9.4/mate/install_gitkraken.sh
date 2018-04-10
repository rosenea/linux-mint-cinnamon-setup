#!/bin/bash
#
# Install Gitkraken.

if ! $(dpkg-query -s gitkraken >/dev/null 2>/dev/null || which gitkraken >/dev/null 2>/dev/null); then
	sudo apt -yq install libcurl3
	wget -O ~/Downloads/gitkraken.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb
	if test "$?" != "0"; then
		echo "
[ERROR] Failed to get gitkraken deb
[ERROR] Exit Code: $?
"
		exit 1
	fi

	sudo dpkg -i ~/Downloads/gitkraken.deb
	rm -f ~/Downloads/gitkraken.deb
	sudo apt -yfq install
	sudo apt -yq update
	sudo apt -yq upgrade
fi


#
# Increase the inotify limit.
#
if test ! -f /etc/sysctl.conf_old; then
	sudo cp -f /etc/sysctl.conf /etc/sysctl.conf_old
	sudo chmod 0777 /etc/sysctl.conf
	echo "fs.inotify.max_user_watches=5242881" >> /etc/sysctl.conf
	sudo chmod 0644 /etc/sysctl.conf
	REBOOT=0
fi
