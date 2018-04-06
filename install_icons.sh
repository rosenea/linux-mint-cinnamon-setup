#!/bin/bash
#
# Install all of the icons in the icons dir that are not currently installed.

AR_DIR=$(dirname $(realpath $0))

for icon in $(ls -d1 ${AR_DIR}/icons/*/ | rev | cut -d'/' -f2 | rev); do
  if test ! -d /usr/share/icons/${icon}; then
    sudo cp -rf ${AR_DIR}/icons/${icon} /usr/share/icons/${icon}
  fi
done
