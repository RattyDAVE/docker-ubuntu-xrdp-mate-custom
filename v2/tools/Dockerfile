FROM rattydave/docker-ubuntu-xrdp-mate-custom:v2

WORKDIR /root

#ADD rocket2014.tar.gz /opt

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
        git build-essential qt5-default \
        libqt5widgets5 && \
    wget --no-check-certificate https://release.gitkraken.com/linux/gitkraken-amd64.deb && \
    dpkg -i gitkraken-amd64.deb; apt-get install -f -y && \
    wget --no-check-certificate https://go.skype.com/skypeforlinux-64.deb && \ 
    dpkg -i skypeforlinux-64.deb; apt-get install -f -y   && \
    wget http://www.bluej.org/download/files/BlueJ-linux-410.deb  && \ 
    dpkg -i BlueJ-linux-410.deb; apt-get install -f -y && \
    rm -f *.deb  && \
    git clone https://github.com/jeroennijhof/vncpwd.git && \
    cd vncpwd && \
    make -j4 && \
    cp vncpwd /usr/bin && \
    rm -R /root/vncpwd && \
    cd /root  && \
    git clone https://github.com/trcwm/rocket2014.git && \
    cd /root/rocket2014/src && \
    qmake && \
    make -j4 && \
    cp Rocket2014 /usr/bin && \
    mkdir -p /opt/rocket2014  && \
    cd ../examples && \
    cp *.* /opt/rocket2014 && \
    cd /root && \
    rm -R /root/rocket2014 && \
    apt-get -y purge git build-essential qt5-default  && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/*  && \
    echo "[Desktop Entry]" > /usr/share/applications/rocket2014.desktop && \
    echo "Name=Rocket2014" >> /usr/share/applications/rocket2014.desktop && \
    echo "Comment=RC2014 Z80 emulator" >> /usr/share/applications/rocket2014.desktop && \
    echo "Exec=/usr/bin/Rocket2014" >> /usr/share/applications/rocket2014.desktop && \
    echo "Terminal=false" >> /usr/share/applications/rocket2014.desktop && \
    echo "Type=Application" >> /usr/share/applications/rocket2014.desktop    

RUN echo #!/bin/bash > /usr/bin/sysinfo && \
    echo "echo You are connected to display ${DISPLAY:1:2} > ~/Desktop/session_info.txt" >> /usr/bin/sysinfo && \
    echo "echo VNC Authentication file is ~/.vnc/sesman_$(whoami)_passwd:${DISPLAY:1:2} >> ~/Desktop/session_info.txt > ~/Desktop/session_info.txt" >> /usr/bin/sysinfo && \
    echo "vncpwd ~/.vnc/sesman_$(whoami)_passwd:${DISPLAY:1:2} >> ~/Desktop/session_info.txt" >> /usr/bin/sysinfo

RUN echo "[Desktop Entry]" > /etc/xdg/autostart/sysinfo.desktop && \
    echo "Name=SystemInfo" >> /etc/xdg/autostart/sysinfo.desktop && \
    echo "Comment=Put System Info in File" >> /etc/xdg/autostart/sysinfo.desktop && \
    echo "Exec=sysinfo" >> /etc/xdg/autostart/sysinfo.desktop && \
    echo "Terminal=false" >> /etc/xdg/autostart/sysinfo.desktop && \
    echo "Type=Application" >> /etc/xdg/autostart/sysinfo.desktop
