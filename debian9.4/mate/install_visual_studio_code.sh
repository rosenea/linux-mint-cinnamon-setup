#!/bin/bash
#
# Install Visual Studio Code.
#
# TODO I need to find a way for this to grab the default configuration information.

if test ! $(which code); then
	wget -O ~/Downloads/code.deb https://az764295.vo.msecnd.net/stable/79b44aa704ce542d8ca4a3cc44cfca566e7720f1/code_1.21.1-1521038896_amd64.deb
	if test "$?" != "0"; then
		echo "
[ERROR] Failed to get visual studio code deb.
[ERROR] Exit code: $?
"
		exit 1
	fi

	sudo dpkg -i ~/Downloads/code.deb
	rm -f ~/Downloads/code.deb
	sudo apt -yfq install
	sudo apt -yq update
	sudo apt -yq upgrade
fi
