#!/bin/bash

#Set Timezone
if [[ -z "${TZ}" ]]; then
   ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
   dpkg-reconfigure -f noninteractive tzdata
else
   ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime
   dpkg-reconfigure -f noninteractive tzdata
fi

#Set Locale
if [[ -z "${LOCALE}" ]]; then
    locale-gen en_GB.UTF-8
    update-locale LANG=en_GB.UTF-8 
else
    locale-gen ${LOCALE}
    update-locale LANG=${LOCALE}
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
                echo "$username:$password" | chpasswd
                if [ "$is_sudo" = "Y" ]
                  then
                    usermod -aG sudo $username
                fi
            fi
    done <"$file"
fi


startfile="/root/extrastartup.sh"
if [ -f $startfile ]
  then
    sh $startfile
fi


#This has to be the last command!
/usr/bin/supervisord -n
