# Ubuntu 16.04 with XRDP and MATE. Version 2

## rattydave/docker-ubuntu-xrdp-mate-custom:latest points to v2

A virtual desktop docker conainer with persistant user information.

This image is automatically rebuilt when updates are realeased for Ubuntu.

Contents:
- Ubuntu 16.04
- Mate Desktop (ubuntu repo)
- XRDP built from source
- XRPDXORG built from source
- tightvncserver (ubuntu repo)
- X11vnc (ubuntu repo)
- openssh-server (always useful)
- Custom xrdp.ini script
- UK Keyboard layout
- UK Timezone

Reasons for choosing the souce of XRDP and XRDPXORG over the repo versions is that the display can resized. Also xorg is far more effecient at memory and processing. 

```
docker run -d --name RattyDAVEv2 \
           -p 3389:3389 \
           -p 2222:22 \
           -v %LOCAL_PATH_TO_CREATEUSERS.TXT_FILE%:/root/createusers.txt \
           -v %LOCAL_PATH_TO_HOME_DIRECTORY%:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:latest
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
docker run -d --name RattyDAVEv2 \
           -p 3389:3389 \
           -v /root/createusers.txt:/root/createusers.txt \
           -v /root/home:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:latest
```

## rattydave/docker-ubuntu-xrdp-mate-custom:v2-tools

I doubt most people would want this version but I have made available. This release contains development tools.

- filezilla
- netbeans
- dia
- geany
- putty
- mysql-workbench
- caja-dropbox
- remmina 
- openjdk-9-jre
- libreoffice
- pasmo
- gitkraken
- skypeforlinux
- BlueJ
- Rocket2014 (A RC2014 Z80 emulator - https://github.com/trcwm/rocket2014 - ROMs located in /opt/rocket2014/examples)

Screen sharing:
-           On the master user connect using the Xvnc option and login as normal.
-           On the desktop there is a file called session_info.txt this will contain the display number and password.
-           
-           On the other clients connect using the Reconnect option.
-           Using the information in the session_info file:
-                PORT = 5900 + display number. (So if display is 11 then the port would be 5911)
-                USERNAME = Username of the master account.
-                PASSWORD = the password in the Session_info.txt file. (e.g. 1a2b3c4d)
                

Example of a working command line.
```
docker run -d --name RattyDAVEv2-tools \
           -p 3389:3389 -p 2222:22 \
           -v /root/createusers.txt:/root/createusers.txt \
           -v /root/home:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:v2-tools
```

## Previous Versions.

### rattydave/docker-ubuntu-xrdp-mate-custom:v1

Build contains.

- ubuntu 16.04
- mate desktop
- xrdp
- firefox
- remmina
- UK Keyboard layout
- UK Timezone

```
docker run -d --name Desktop -p 3389:3389 rattydave/docker-ubuntu-xrdp-mate-custom:v1
```

### rattydave/docker-ubuntu-xrdp-mate-custom:v1-users

As core.

- Added desktop user as a local user.
- username desktop
- password desktop
- Also has sudo rights.

Started implmentation for external users. 

Local users only.
```
docker run -d --name Desktop -p 3389:3389 rattydave/docker-ubuntu-xrdp-mate-custom:v1-users
```

External User support. 
Change %HOST_VOLUME_FOR_HOME% to the external volume.
```
docker run -d --name Desktop -v %HOST_VOLUME_FOR_HOME%:/home_ext -p 3389:3389 rattydave/docker-ubuntu-xrdp-mate-custom:v1-users
```
