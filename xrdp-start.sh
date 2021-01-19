#!/bin/bash

startfile="/root/startup.sh"

if [ -f $startfile ]

  then

    sh $startfile

fi

echo "export QT_XKB_CONFIG_ROOT=/usr/share/X11/locale" >> /etc/profile

# Create the PrivSep empty dir if necessary

if [ ! -d /run/sshd ]; then

   mkdir /run/sshd

   chmod 0755 /run/sshd

fi

#This has to be the last command!

/usr/bin/supervisord -n
