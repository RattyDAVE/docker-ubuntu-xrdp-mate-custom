FROM rattydave/docker-ubuntu-xrdp-mate-custom:rolling-users-TEST

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    xterm \
    filezilla \
    netbeans \
    dia \
    geany \
    putty \
    mysql-workbench 
    
RUN apt-get install -y \
    caja-dropbox \
    remmina* \
    libreoffice
    
# Install Skype
#RUN    apt-get install --no-install-recommends -y libxss1 libappindicator1 libindicator7 xdg-utils
WORKDIR /root
RUN    wget --no-check-certificate https://go.skype.com/skypeforlinux-64.deb
RUN    apt-get install -y apt-transport-https
RUN    dpkg -i skypeforlinux-64.deb && apt-get install -f

RUN wget http://www.bluej.org/download/files/BlueJ-linux-410.deb
RUN apt-get install -y openjdk-9-jre
RUN dpkg --install BlueJ-linux-410.deb && apt-get -f install

RUN    apt-get autoclean && apt-get autoremove
RUN    rm -rf /var/lib/apt/lists/*
