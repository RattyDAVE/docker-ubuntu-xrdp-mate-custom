Use https://github.com/RattyDAVE/docker-ubuntu-xrdp-mate-custom/issues to send feedback, issues, comments and general chat.

## rattydave/docker-ubuntu-xrdp-mate-custom:stable points to 18.04
## rattydave/docker-ubuntu-xrdp-mate-custom:latest points to 19.10
## rattydave/docker-ubuntu-xrdp-mate-custom:beta points to 20.04

A virtual desktop docker container with persistant user information.

This image is automatically rebuilt when updates are realeased for Ubuntu.

# Ubuntu 19.10 with XRDP and MATE. (latest)

- rattydave/docker-ubuntu-xrdp-mate-custom:19.10
- rattydave/docker-ubuntu-xrdp-mate-custom:19.10-tools

All features as 19.04 with the following new features.
 - Ability to run a script on container startup. This is useful for installing packages that are needed.
 - You are now able to set the time zone with the TZ variable

This version supports local drive mapping and clipboard sharing. Also manual mounting of file systems. To use these features you will need to add the elevated rights with this parameter ```--privileged=true``` also this could be a securty risk.

Contents:
- Ubuntu 19.10
- Mate Desktop (ubuntu repo)
- XRDP (built from source)
- XRPDXORG (built from source)
- tightvncserver (ubuntu repo)
- Epiphany web browser (ubuntu repo)
- openssh-server (always useful)
- Custom xrdp.ini script
- Default UK Keyboard layout (Can be changed)
- Default UK Timezone (Can be changed)
 
 ```
 docker run --name RattyDAVE19.10 \
           --privileged=true \
           -p 3389:3389 \
           -e TZ="Europe/London"
           -v %LOCAL_PATH_TO_CREATEUSERS.TXT_FILE%:/root/createusers.txt \
           -v %LOCAL_PATH_TO_STARTUP.SH_FILE%:/root/startup.sh \
           -v %LOCAL_PATH_TO_HOME_DIRECTORY%:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:19.10
```

- Replace %LOCAL_PATH_TO_CREATEUSERS.TXT_FILE% with the local filename of the createusers file.
- Replace %LOCAL_PATH_TO_STARTUP.SH_FILE% with the local filename of the startup.sh script. This is run after the user creation and before the service start.
- Replace %LOCAL_PATH_TO_HOME_DIRECTORY% with the local directory of the /home directorys.
- You do not need to publish port 22 only use if needed.

Example startup.sh to change locale.
```
apt-get update
apt-get -y install language-pack-de language-pack-gnome-de
locale-gen de_DE.UTF-8
update-locale LANG=de_DE.UTF-8
```


## To Connect
Please note some clients need an extra parameter set glyph-cache. xfreerdp and remmina and other need this set.

Linux example of how to connect:

```
xfreerdp /size:1920x1140 /kbd:0x00000809 /v:%IP_ADDRESS% /gdi:hw /drive:home,$HOME +clipboard /sound:sys:alsa +glyph-cache
```


# Ubuntu 19.04 with XRDP and MATE. Version 19.04

- rattydave/docker-ubuntu-xrdp-mate-custom:19.04
- rattydave/docker-ubuntu-xrdp-mate-custom:19.04-tools

This version supports local drive mapping and clipboard sharing. Also manual mounting of file systems. To use these features you will need to add the elevated rights with this parameter ```--privileged=true``` also this could be a securty risk.

Contents:
- Ubuntu 19.04
- Mate Desktop (ubuntu repo)
- XRDP (built from source)
- XRPDXORG (built from source)
- tightvncserver (ubuntu repo)
- Epiphany web browser (ubuntu repo)
- openssh-server (always useful)
- Custom xrdp.ini script
- UK Keyboard layout 
- UK Timezone

```
docker run --name RattyDAVE19.04 \
           --privileged=true \
           -p 3389:3389 \
           -v %LOCAL_PATH_TO_CREATEUSERS.TXT_FILE%:/root/createusers.txt \
           -v %LOCAL_PATH_TO_HOME_DIRECTORY%:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:19.04
```

- Replace %LOCAL_PATH_TO_CREATEUSERS.TXT_FILE% with the local filename of the createusers file.
- Replace %LOCAL_PATH_TO_HOME_DIRECTORY% with the local directory of the /home directorys.
- You do not need to publish port 22 only use if needed.

This file contains 3 fields (username:password:is_sudo). Where username is the login id. Password is the password. is_sudo does the user have sudo access(only Y is recognised). It also needs a "newline" at the end of the line.  

Example

```
mickey:mouse:N
daisy:duke:Y
dog:flash:n
morty:rick:wubba
```

In this example 4 users will be created and only daisy will have sudo rights.

At every reboot it will check this file and ADD any new users.

Example of a working command line.

```
docker run -d --name RattyDAVE19.04 \
           -p 3389:3389 \
           -v /root/createusers.txt:/root/createusers.txt \
           -v /root/home:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:19.04

```

Please note some clients need an extra parameter set glyph-cache. xfreerdp and remmina and other need this set.

Linux example of how to connect ```xfreerdp /v:xxx.xxx.xxx.xxx /drive:home,/home/xxxx +clipboard +glyph-cache```


## rattydave/docker-ubuntu-xrdp-mate-custom:18.04-tools

I doubt most people would want this version but I have made available. This release contains development tools.

- x3270
- filezilla
- netbeans
- dia
- geany
- putty
- mysql-workbench
- remmina 
- openjdk-11-jre
- libreoffice
- pasmo
- BlueJ
- Rocket2014 (A RC2014 Z80 emulator - https://github.com/trcwm/rocket2014 - ROMs located in /opt/rocket2014/examples)

Screen sharing:
           On the master user connect using the Xvnc option and login as normal.
           On the desktop there is a file called session_info.txt this will contain the display number and password.
           
           On the other clients connect using the Reconnect option.
           Using the information in the session_info file:
                PORT = 5900 + display number. (So if display is 11 then the port would be 5911)
                USERNAME = Username of the master account.
                PASSWORD = the password in the Session_info.txt file. (e.g. 1a2b3c4d)
                

Example of a working command line.

```
docker run -d --name RattyDAVE19.04-tools \
           -p 3389:3389 \
           -v /root/createusers.txt:/root/createusers.txt \
           -v /root/home:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:19.04-tools
```

Please note some clients need an extra parameter set glyph-cache. xfreerdp and remmina and other need this set.

Linux example of how to connect ```xfreerdp /v:xxx.xxx.xxx.xxx /drive:home,/home/xxxx +clipboard +glyph-cache```

## rattydave/docker-ubuntu-xrdp-mate-custom:18.04

Contents:
- Ubuntu 18.04
- Mate Desktop (ubuntu repo)
- XRDP built from source (ubuntu repo)
- XRPDXORG built from source (ubuntu repo)
- tightvncserver (ubuntu repo)
- Epiphany web browser (ubuntu repo)
- openssh-server (always useful)
- Custom xrdp.ini script
- UK Keyboard layout 
- UK Timezone

```

docker run --name RattyDAVE18.04 \
           -p 3389:3389 \
           -p 2222:22 \
           -v %LOCAL_PATH_TO_CREATEUSERS.TXT_FILE%:/root/createusers.txt \
           -v %LOCAL_PATH_TO_HOME_DIRECTORY%:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:18.04

```

- Replace %LOCAL_PATH_TO_CREATEUSERS.TXT_FILE% with the local filename of the createusers file.
- Replace %LOCAL_PATH_TO_HOME_DIRECTORY% with the local directory of the /home directorys.
- You do not need to publish port 22 only use if needed.

This file contains 3 fields (username:password:is_sudo). Where username is the login id. Password is the password. is_sudo does the user have sudo access(only Y is recognised).

Example

```

mickey:mouse:N
daisy:duke:Y
dog:flash:n
morty:rick:wubba

```

In this example 4 users will be created and only daisy will have sudo rights.

At every reboot it will check this file and ADD any new users.

Example of a working command line.

```

docker run -d --name RattyDAVE18.04 \
           -p 3389:3389 \
           -v /root/createusers.txt:/root/createusers.txt \
           -v /root/home:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:18.04

```

## rattydave/docker-ubuntu-xrdp-mate-custom:18.04-tools

I doubt most people would want this version but I have made available. This release contains development tools.

- x3270
- filezilla
- netbeans
- dia
- geany
- putty
- mysql-workbench
- remmina 
- openjdk-11-jre
- libreoffice
- pasmo
- BlueJ
- Rocket2014 (A RC2014 Z80 emulator - https://github.com/trcwm/rocket2014 - ROMs located in /opt/rocket2014/examples)

Screen sharing:
           On the master user connect using the Xvnc option and login as normal.
           On the desktop there is a file called session_info.txt this will contain the display number and password.
           
           On the other clients connect using the Reconnect option.
           Using the information in the session_info file:
                PORT = 5900 + display number. (So if display is 11 then the port would be 5911)
                USERNAME = Username of the master account.
                PASSWORD = the password in the Session_info.txt file. (e.g. 1a2b3c4d)
                

Example of a working command line.

```

docker run -d --name RattyDAVE18.04-tools \
           -p 3389:3389 -p 2222:22 \
           -v /root/createusers.txt:/root/createusers.txt \
           -v /root/home:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:18.04-tools

```

## Previous Versions.

## rattydave/docker-ubuntu-xrdp-mate-custom:v2

Contents:
- Ubuntu 16.04
- Mate Desktop (ubuntu repo)
- XRDP built from source (devel branch)
- XRPDXORG built from source (devel branch)
- tightvncserver (ubuntu repo)
- Epiphany web browser (ubuntu repo)
- openssh-server (always useful)
- Custom xrdp.ini script
- UK Keyboard layout
- UK Timezone

Reasons for choosing the souce of XRDP and XRDPXORG over the repo versions is that the display can resized. Also xorg is far more effecient at memory and processing. (At present. I have experimented with ubuntu 17.xx and this is not the case anymore)

