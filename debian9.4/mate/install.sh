#!/bin/bash
#
# This is the Debian 9.4 - MATE install variant.
#
# TODO I need to find a way for this to force itself into another file.


###############################################################################
# GLOBAL VARIABLES
PKG_INSTALLED=1
REBOOT=1

###############################################################################
# FUNCTION BLOCK
is_installed () {
	dpkg-query -s $1 >/dev/null 2>/dev/null || which $1 >/dev/null 2>/dev/null
}

install_packages () {
	# Reset the package installed indicator
	PKG_INSTALLED=1

	for pkg in "$@"; do
		if ! is_installed $pkg; then
			echo "[installing] $pkg"
			
			# Attempt package installation
			if sudo apt -yq install $pkg; then
				PKG_INSTALLED=0
			else
				echo -e "\n[ERROR] Failed to install package $pkg\n"
				exit 1
			fi
		fi
	done
}


###############################################################################
# SCRIPT BLOCK


#
# Abort the script if called from root user
#
if test "$LOGNAME" = "root" ; then
	echo -e "\n[ERROR] Cannot run script as root.\n"
	exit 1
fi


#
# Install sudo if missing (first boot only here)
#
if ! is_installed sudo; then
	echo -n "Root " ; su -c "apt-get -yq install sudo ; usermod -aG sudo $LOGNAME ; reboot"
fi


#
# Update the source lists
#
if test ! -f /etc/apt/sources.list_old ; then
	sudo sed -i_old 's/^deb-src/#\ deb-src/' /etc/apt/sources.list
	sudo sed -i '/^deb\ /s/$/ contrib\ non-free/' /etc/apt/sources.list
	sudo apt -yq update
	sudo apt -yq upgrade
	sudo apt -yq dist-upgrade
	sudo apt -yq autoclean
	sudo apt -yq autoremove
	sudo reboot
fi


#
# Install the required drivers
#
install_packages firmware-linux firmware-iwlwifi
if test "$PKG_INSTALLED" = "0"; then
	sudo reboot
fi


#
# Install other required packages (find a way to ensure this is done only once).
#
install_packages curl \
	wget \
	zip \
	unzip \
	openjdk-8-jdk \
	build-essential \
	cmake \
	dconf-editor \
	gparted \
	hardinfo \
	git \
	vlc


#
# Create required ~/.mybashrc and reference at start of ~/.bashrc
#
if test ! -f ~/.mybashrc; then
	# Create ~/.mybashrc
	touch ~/.mybashrc
	# include as first line in ~/.bashrc so it will be called first every time the shell is used.
	sed -i '1s/^/.\ ~\/.mybashrc\n/' ~/.bashrc
fi


#
# Install git-lfs
#
if ! is_installed git-lfs; then
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
	sudo apt -yfq install
	sudo apt -yq update
	sudo apt -yq upgrade

	# Install git lfs
	install_package git-lfs

	# initialize git lfs
	git lfs install
fi


#
# Install skypeforlinux
#
if ! is_installed skypeforlinux; then
	wget -O ~/Downloads/skype.deb https://repo.skype.com/latest/skypeforlinux-64.deb
	# Handle the error case
	if test "$?" != "0"; then
		echo "
[ERROR] Failed to get skypeforlinux deb file.
[ERROR] Exit Code: $?
"
		exit 1
	fi
	
	# Install the deb file then remove it
	sudo dpkg -i ~/Downloads/skype.deb
	rm -f ~/Downloads/skype.deb

	# Fix any broken deps
	sudo apt -yfq install
	sudo apt -yq update
	sudo apt -yq upgrade
fi


#
# Install Evolution
#
install_packages evolution evolution-ews evolution-plugins


#
# Install VPN Packages
#
install_packages network-manager-openconnect network-manager-openconnect-gnome


#
# Install Gradle 4.6
#
if ! is_installed gradle; then
	wget -O ~/Downloads/gradle.zip https://services.gradle.org/distributions/gradle-4.6-all.zip
	# Handle the error case
	if test "$?" != "0"; then
		echo "
[ERROR] Failed to get gradle.zip.
[ERROR] Exit Code: $?
"
		exit 1
	fi

	# create the required directory
	sudo mkdir /opt/gradle
	sudo unzip -d /opt/gradle ~/Downloads/gradle.zip
	
	# Handle any error codes
	if test "$?" != "0"; then
		echo "
[ERROR] Failed to unzip the gradle archive.
[ERROR] Exit Code: $?
"
		rm -f ~/Downloads/gradle.zip
		exit 1
	else
		rm -f ~/Downloads/gradle.zip
	fi

	# Add the gradle information to the ~/.mybashrc
	if test "$(grep \"GRADLE_OPTS=\" ~/.mybashrc)" = ""; then
		echo "export PATH=\$PATH:/opt/gradle/gradle-4.6/bin" >> ~/.mybashrc
		# TODO Decide whether this should be reduced or not.
		echo "export GRADLE_OPTS=\"-Dorg.gradle.jvmargs=-Xms1024m -Xmx4096m\"" >> ~/.mybashrc
	fi
fi


#
# Install Ccache
#
install_packages ccache
if is_installed ccache && test "$(grep 'USE_CCACHE=' ~/.mybashrc)" = ""; then
	echo "export USE_CCACHE=1" >> ~/.mybashrc
	echo "export CACCHE_DIR=~/.ccache" >> ~/.mybashrc
fi


#
# Install Gitkraken
#
curl -s https://raw.githubusercontent.com/rosenea/linux-setup/master/debian9.4/mate/install_gitkraken.sh | bash


#
# Install Password Safe
#
curl -s https://raw.githubusercontent.com/rosenea/linux-setup/master/debian9.4/mate/install_password_safe.sh | bash


#
# Install the Android NDK
#
curl -s https://raw.githubusercontent.com/rosenea/linux-setup/master/debian9.4/mate/install_android_ndk.sh | bash


#
# Install the Android SDK
#
curl -s https://raw.githubusercontent.com/rosenea/linux-setup/master/debian9.4/mate/install_android_sdk.sh | bash

#
# Install Android Tools
#
install_packages adb fastboot


#
# Install Dropbox
#
install_packages caja-dropbox


#
# Install Filezilla
#
install_packages filezilla


#
# Install VSCode
#
curl -s https://raw.githubusercontent.com/rosenea/linux-setup/master/debian9.4/mate/install_visual_studio_code.sh | bash


#
# Force restart
#
# TODO











