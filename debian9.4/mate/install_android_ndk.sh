#!/bin/bash
#
# Install the Android NDK.

# Add the android ndk to the correct location
if test ! -d ~/Android/ndk; then
	wget -O ~/Downloads/android-ndk.zip https://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip
	if test "$?" != "0"; then
		echo "
[ERROR] Failed to download android ndk.
[ERROR] Exit Code: $?
"
		exit 1
	fi

	mkdir ~/Android
	unzip -d ~/Android ~/Downloads/android-ndk.zip
	if test "$?" != "0"; then
		echo "
[ERROR] Failed to unzip the android ndk.
[ERROR] Exit Code: $?
"
		rm -f ~/Downloads/android-ndk.zip
		exit 1
	else
		rm -f ~/Downloads/android-ndk.zip
	fi

	mv ~/Android/android-ndk-r10e ~/Android/ndk
fi


# Add to the mybashrc
if test -d ~/Android/ndk; then
	# TODO Have this call create_mybashrc here
	
	# Update mybashrc
	if test "$(grep 'ANDROID_NDK=' ~/.mybashrc)" = ""; then
		echo "export ANDROID_NDK=~/Android/ndk" >> ~/.mybashrc
		echo "export ANDROID_NDK_HOME=~/Android/ndk" >> ~/.mybashrc
		echo "export ANDROID_HOME=~/Android/Sdk" >> ~/.mybashrc
	fi
fi
