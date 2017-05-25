#!/bin/bash

# Add desktop user and generate a random password with 12 characters that includes at least one capital letter and number.
DESKTOP_PASSWORD=`pwgen -c -n -1 12`
echo User: desktop Password: $DESKTOP_PASSWORD
DESKTOP_ENCRYPYTED_PASSWORD=`perl -e 'print crypt('"$DESKTOP_PASSWORD"', "aa"),"\n"'`
useradd -m -d /home/desktop -p $DESKTOP_ENCRYPYTED_PASSWORD desktop

# Add god user and generate a random password with 12 characters that includes at least one capital letter and number.
GOD_PASSWORD=`pwgen -c -n -1 12`
echo User: god Password: $GOD_PASSWORD
GOD_ENCRYPYTED_PASSWORD=`perl -e 'print crypt('"$GOD_PASSWORD"', "aa"),"\n"'`
useradd -m -d /home/god -p $GOD_ENCRYPYTED_PASSWORD god

adduser god sudo
