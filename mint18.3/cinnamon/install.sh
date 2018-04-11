#!/bin/bash
#
# Install script for Linux Mint 18.3 - Cinnamon

PKG_INSTALLED=1

# --- FUNCTION BLOCK -----------------------------------------------------------
is_installed () {
    dpkg-query -s $1 >/dev/null 2>/dev/null || which $1 >/dev/null 2>/dev/null
}

install_packages () {
    PKG_INSTALLED=1

    for $pkg in "$@"; do
        if ! is_installed $pkg; then
            echo "[INSTALLING] $pkg"

            if sudo apt-get -yq install $pkg; then
                PKG_INSTALLED=0
            else
                echo -e "\n[ERROR] Failed to install package $pkg\n"
                exit 1
            fi
        fi
    done
}


# --- SCRIPT BLOCK -------------------------------------------------------------
