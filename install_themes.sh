#!/bin/bash
#
# This installs all of the themes in the themes dir that are not currently
# installed.

AR_DIR=$(dirname $(realpath $0))

for theme in $(ls -d1 ${AR_DIR}/themes/*/ | rev | cut -d'/' -f2 | rev); do
  if test ! -d /usr/share/themes/${theme}; then
    sudo cp -rf ${AR_DIR}/themes/${theme} /usr/share/themes/${theme}
  fi
done