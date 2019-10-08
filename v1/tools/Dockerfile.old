FROM rattydave/docker-ubuntu-xrdp-mate-custom:v1-users

RUN     apt-get update -y && \
    apt-get install --no-install-recommends -y \
    filezilla \
    netbeans \
    dia \
    geany \
    putty \
    mysql-workbench \
    remmina*
    
RUN apt-get install -y \
    caja-dropbox
    
# Install Skype
#RUN    apt-get install --no-install-recommends -y libxss1 libappindicator1 libindicator7 xdg-utils
RUN    wget --no-check-certificate https://go.skype.com/skypeforlinux-64.deb
RUN    apt-get install -y apt-transport-https
RUN    dpkg -i skypeforlinux-64.deb
#RUN    apt-get install -f

RUN    apt-get autoclean && apt-get autoremove
RUN    rm -rf /var/lib/apt/lists/*
