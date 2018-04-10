#!/bin/bash
#
# Install the Android SDK

if test ! $(which android-studio); then
	if test ! -d /opt/android-studio; then
		wget -O ~/Downloads/android-studio.zip https://dl.google.com/dl/android/studio/ide-zips/3.1.0.16/android-studio-ide-173.4670197-linux.zip
		if test "$?" != "0"; then
			echo "
[ERROR] Failed to get android studio archive.
[ERROR] Exit Code: $?
"
			exit 1
		fi

		# Unzip the archive
		sudo unzip -d /opt ~/Downloads/android-studio.zip
		if test "$?" != "0"; then
			echo "
[ERROR] Failed to unzip the android sdk.
[ERROR] Exit Code: $?
"
			rm -f ~/Downloads/android-studio.zip
			exit 1
		else
			rm -f ~/Download/android-studio.zip
		fi
	fi

	# Make a symbolic link to the startup script.
	if test -f /usr/bin/android-studio; then
		sudo ln -sf /opt/android-studio/bin/studio.sh /usr/bin/android-studio
	fi
fi

# Create the required customization if installed
if which android-studio >/dev/null 2>/dev/null; then
	if test ! -f ~/.AndroidStudio3.1/config/studio64.vmoptions; then
		# Create the parent directories if missing
		test ! -d ~/.AndroidStudio3.1/config && mkdir -p ~/.AndroidStudio3.1/config

		# Create the configuration file
		echo "-Xmx4096m" > ~/.AndroidStudio3.1/config/studio64.vmoptions
	fi
fi
