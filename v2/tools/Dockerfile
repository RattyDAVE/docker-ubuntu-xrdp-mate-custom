FROM rattydave/docker-ubuntu-xrdp-mate-custom:v2

WORKDIR /root

ADD rocket2014.tar.gz /opt

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
        libreoffice \
        pasmo \
        libqt5widgets5 && \
    wget --no-check-certificate https://release.gitkraken.com/linux/gitkraken-amd64.deb && \
    dpkg -i gitkraken-amd64.deb; apt-get install -f -y && \
    wget --no-check-certificate https://go.skype.com/skypeforlinux-64.deb && \ 
    dpkg -i skypeforlinux-64.deb; apt-get install -f -y   && \
    wget http://www.bluej.org/download/files/BlueJ-linux-410.deb  && \ 
    dpkg -i BlueJ-linux-410.deb; apt-get install -f -y && \
    rm -f *.deb && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/*
