#!/bin/bash
#
# Install all fonts from the fonts directory.

AR_DIR=$(dirname $(realpath $0))
ADDED=1

if test "$LOGNAME" = "root"; then
  echo -e "\n[ERROR] Cannot run script as root.\n"
  exit 1
fi

# create the local font directory if it doesn't exist
if test ! -d /home/$LOGNAME/.fonts; then
  mkdir /home/$LOGNAME/.fonts
fi

for family in $(ls -d1 ${AR_DIR}/fonts/*/ | rev | cut -d'/' -f2 | rev); do
  for font in $(ls ${AR_DIR}/fonts/${family}/* | rev | cut -d'/' -f1 | rev); do
    if test ! -f /home/$LOGNAME/.fonts/${font}; then
      cp -f ${AR_DIR}/fonts/${family}/${font} /home/$LOGNAME/.fonts/${font}
      ADDED=0
    fi
  done
done

# Update the font cache if something was added.
test "$ADDED" = "0" && fc-cache