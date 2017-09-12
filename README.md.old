Note:

See https://hub.docker.com/r/rattydave/docker-ubuntu-xrdp-mate-custom/

rattydave/docker-ubuntu-xrdp-mate-custom:core 

Build contains.

ubuntu 16.04
mate desktop
xrdp
firefox
remmina

UK Keyboard layout
UK Timezone

docker run -d --name Desktop -p 3389:3389 rattydave/docker-ubuntu-xrdp-mate-custom:core


rattydave/docker-ubuntu-xrdp-mate-custom:users

As core. - UNDER DEVELOPMENT.

Added desktop user as a local user.
username desktop
password desktop
Also has sudo rights.

Started implmentation for external users. 

Local users only.
docker run -d --name Desktop -p 3389:3389 rattydave/docker-ubuntu-xrdp-mate-custom:users

External User support. 
Change %HOST_VOLUME_FOR_HOME% to the external volume.
docker run -d --name Desktop -v %HOST_VOLUME_FOR_HOME%:/home_ext -p 3389:3389 rattydave/docker-ubuntu-xrdp-mate-custom:users
