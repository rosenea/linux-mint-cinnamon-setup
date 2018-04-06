#!/bin/bash
#
# Uninstall all fonts from the fonts directory.

AR_DIR=$(dirname $(realpath $0))
REMOVED=1

if test "$LOGNAME" = "root"; then
  echo -e "\n[ERROR] Cannot run script as root. Not allowed.\n"
  exit 1
fi

for family in $(ls -d1 ${AR_DIR}/fonts/*/ | rev | cut -d'/' -f2 | rev); do
  for font in $(ls ${AR_DIR}/fonts/${family}/* | rev | cut -d'/' -f1 | rev); do
    if test -f /home/$LOGNAME/.fonts/${font}; then
      rm -f /home/$LOGNAME/.fonts/${font}
      REMOVED=0
    fi
  done
done

# Update the font cache if something is removed.
test "$REMOVED" = "0" && fc-cache