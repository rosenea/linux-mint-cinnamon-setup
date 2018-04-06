#!/bin/bash
#
# Uninstall all of the installed icons specified in the icons dir.

AR_DIR=$(dirname $(realpath $0))

for icon in $(ls -d1 ${AR_DIR}/icons/*/ | rev | cut -d'/' -f2 | rev); do
  if test -d /usr/share/icons/${icon}; then
    sudo rm -rf /usr/share/icons/${icon}
  fi
done
