FROM rattydave/docker-ubuntu-xrdp-mate-custom:rolling-users-TEST

RUN apt-get update -yqq && \
    apt-get install --no-install-recommends -y \
    xterm \
    curl \
    filezilla \
    netbeans \
    dia \
    geany \
    putty \
    mysql-workbench 
    
RUN apt-get install -yqq \
    caja-dropbox \
    remmina* \
    libreoffice
    
# Install Skype
#RUN    apt-get install --no-install-recommends -y libxss1 libappindicator1 libindicator7 xdg-utils
WORKDIR /root
RUN    wget --no-check-certificate https://go.skype.com/skypeforlinux-64.deb
RUN    apt-get install -yqq apt-transport-https
RUN    dpkg -i skypeforlinux-64.deb && apt-get install -f -yqq

RUN wget http://www.bluej.org/download/files/BlueJ-linux-410.deb
RUN apt-get install -yqq openjdk-9-jre
RUN dpkg -i BlueJ-linux-410.deb; apt-get install -f -y

#RUN set -xe \
#    && curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
#    && apt-get update \
#    && apt-get install -y google-chrome-stable


#RUN    apt-get autoclean && apt-get autoremove
#RUN    rm -rf /var/lib/apt/lists/*
