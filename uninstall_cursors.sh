#!/bin/bash
#
# This uninstalls all of the installed cursors specified in the cursor dir.

AR_DIR=$(dirname $(realpath $0))
AR_ICON_DIR=/usr/share/icons

for cursor in $(ls -d1 ${AR_DIR}/cursors/*/ | rev | cut -d'/' -f2 | rev); do
  if test -d ${AR_ICON_DIR}/${cursor}/; then
    sudo update-alternatives --remove x-cursor-theme ${AR_ICON_DIR}/${cursor}/cursor.theme
    sudo rm -rf ${AR_ICON_DIR}/${cursor}
  fi
done
