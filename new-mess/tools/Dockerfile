FROM rattydave/docker-ubuntu-xrdp-mate-custom:new-mess

WORKDIR /root

RUN apt-get update -y && \ 
    apt-get install --no-install-recommends -yqq \
        filezilla \
        netbeans \
        dia \
        geany \
        putty \
        mysql-workbench \
        caja-dropbox \
        remmina* \
        apt-transport-https \
        openjdk-9-jre \
        libreoffice && \ 
    wget --no-check-certificate https://go.skype.com/skypeforlinux-64.deb  && \ 
    dpkg -i skypeforlinux-64.deb; apt-get install -f -yqq   && \ 
    wget http://www.bluej.org/download/files/BlueJ-linux-410.deb  && \ 
    dpkg -i BlueJ-linux-410.deb; apt-get install -f -y && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    apt-get -y autoclean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
