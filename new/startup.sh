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
            useradd -ms /bin/bash $username
            echo "$username:$password" | chpasswd
            if [ "$is_sudo" = "Y" ]
                then
                    usermod -aG sudo $username
            fi
    done <"$file"
fi

#This has to be the last command!
/usr/bin/supervisord -n
