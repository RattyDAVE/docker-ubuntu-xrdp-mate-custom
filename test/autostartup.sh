#!/bin/bash

set -eu

# Dump environment variables
# export-env > /etc/profile.d/env.sh

# Remove xdummy if there is no graphics card
#if [ "${DISABLE_GPU:?}" = 'true' ] || [ ! -d /dev/dri/ ]; then
#	rm /etc/supervisor/conf.d/xdummy.conf
#fi

#Set Timezone
if [[ -z "${TZ}" ]]; then
   ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
   dpkg-reconfigure -f noninteractive tzdata
else
   ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime
   dpkg-reconfigure -f noninteractive tzdata
fi

#CREATE USERS.
# username:passsword:Y
# username2:password2:Y

file="/root/createusers.txt"
if [ -f $file ]
  then
    while IFS=: read -r username password is_sudo
        do
            echo "Username: $username, Password: $password , Sudo: $is_sudo"

            if getent passwd $username > /dev/null 2>&1
              then
                echo "User Exists"
              else
                useradd -ms /bin/bash $username
                usermod -aG audio $username
                usermod -aG input $username
                usermod -aG video $username
                echo "$username:$password" | chpasswd
                if [ "$is_sudo" = "Y" ]
                  then
                    usermod -aG sudo $username
                fi
                mkdir -p /run/user/$(id -u $username)/dbus-1/
                chmod -R 700 /run/user/$(id -u $username)/
                chown -R "$username" /run/user/$(id -u $username)/
            fi
    done <"$file"
fi

startfile="/root/startup.sh"
if [ -f $startfile ]
  then
    sh $startfile
fi

echo "export QT_XKB_CONFIG_ROOT=/usr/share/X11/locale" >> /etc/profile

#This has to be the last command!
/usr/bin/supervisord -n
