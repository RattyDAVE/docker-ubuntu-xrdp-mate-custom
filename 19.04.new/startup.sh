#!/bin/bash

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

#### Change hosts file stop ads.

#cd /root
#rm hosts
#wget -o newhosts.txt https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts
#cat /etc/hosts.ori  >/etc/hosts
#cat hosts >> /etc/hosts


#This has to be the last command!
/usr/bin/supervisord -n
