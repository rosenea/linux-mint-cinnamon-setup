#!/bin/bash
#
# Uninstall all the themes in the themes dir.

AR_DIR=$(dirname $(realpath $0))

for theme in $(ls -d1 ${AR_DIR}/themes/*/ | rev | cut -d'/' -f2 | rev); do
  if test -d /usr/share/themes/${theme}; then
    sudo rm -rf /usr/share/themes/${theme}
  fi
done