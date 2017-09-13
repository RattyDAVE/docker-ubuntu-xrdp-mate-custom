FROM rattydave/docker-ubuntu-xrdp-mate-custom:v2

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
    apt-get install -y \
        build-essential \
        m4 \
        libxml2-dev \
        git && \
    git clone https://github.com/z88dk/z88dk.git && \
    cd z88dk && \
    ./build.sh && \
    make install && \
    cd .. && \
    rm -rf z88dk && \
    wget --no-check-certificate https://release.gitkraken.com/linux/gitkraken-amd64.deb && \
    dpkg -i gitkraken-amd64.deb; apt-get install -f -y && \
    wget --no-check-certificate https://go.skype.com/skypeforlinux-64.deb && \ 
    dpkg -i skypeforlinux-64.deb; apt-get install -f -y   && \
    wget http://www.bluej.org/download/files/BlueJ-linux-410.deb  && \ 
    dpkg -i BlueJ-linux-410.deb; apt-get install -f -y && \
    rm -f *.deb && \
    apt-get purge -y \
        build-essential \
        m4 \
        libxml2-dev \
        git && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/*
