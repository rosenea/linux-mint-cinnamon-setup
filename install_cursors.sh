#!/bin/bash
#
# This installs all of the cursors in the cursors dir that are not currently
# installed. Before installing a cursor, this checks that the cursor meets the
# required need.

AR_DIR=$(dirname $(realpath $0))
AR_ICON_DIR=/usr/share/icons
AR_PRIORITY=20

# Install all of the valid cursors from cursor directory.
for cursor in $(ls -d1 ${AR_DIR}/cursors/*/ | rev | cut -d'/' -f2 | rev); do
  if test ! -d ${AR_ICON_DIR}/${cursor} && test -d ${AR_DIR}/cursors/${cursor} && test -f ${AR_DIR}/cursors/${cursor}/cursor.theme; then
    # Move to the correct directory
    sudo cp -rf ${AR_DIR}/cursors/${cursor} ${AR_ICON_DIR}/${cursor}
    # Install the cursor (using the same priority because I still don't understand it yet)
    sudo update-alternatives --install ${AR_ICON_DIR}/default/index.theme x-cursor-theme ${AR_ICON_DIR}/${cursor}/cursor.theme ${AR_PRIORITY}
  fi
done
