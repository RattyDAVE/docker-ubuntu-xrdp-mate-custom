FROM rattydave/docker-ubuntu-xrdp-mate-custom:19.04

WORKDIR /root

RUN apt-get update -y && \ 
    #apt-get install -yqq caja-dropbox && \
    apt-get install --no-install-recommends -yqq \
        git \
        telnet \
        vym \
        x3270 \
        filezilla \
        dia \
        geany \
        putty \
        remmina* \
        openjdk-12-jdk \
        libreoffice \
        pasmo \
        git build-essential qt5-default \
        chromium-browser \
        libqt5widgets5 && \
    sed 's#PLUGIN_PARAMETERS=""#PLUGIN_PARAMETERS="--no-sandbox"#g' /usr/bin/chromium-browser -i  && \        
    wget http://www.bluej.org/download/files/BlueJ-linux-410.deb  && \ 
    dpkg -i BlueJ-linux-410.deb; apt-get install -f -y && \
    rm -f *.deb  && \
    git clone https://github.com/jeroennijhof/vncpwd.git && \
    cd vncpwd && \
    make && \
    cp vncpwd /usr/bin && \
    rm -R /root/vncpwd && \
    cd /root  && \
    git clone https://github.com/BleuLlama/z80-machine.git && \
    cp -R z80-machine/prg /opt/rocket2014 && \
    rm -R /root/z80-machine && \
    git clone https://github.com/ancientcomputing/rc2014.git && \
    cp rc2014/rom/z80/68B50/*.* /opt/rocket2014 && \
    git clone https://github.com/trcwm/rocket2014.git && \
    cd /root/rocket2014/src && \
    qmake && \
    make && \
    cp Rocket2014 /usr/bin && \
    mkdir -p /opt/rocket2014  && \
    cd ../examples && \
    cp *.* /opt/rocket2014 && \
    cd /root && \
    rm -R /root/rocket2014 && \ 
    wget -O /opt/rocket2014/SCMonitor-v100-R1-RC2014-08k-ROM.BIN https://github.com/RattyDAVE/docker-ubuntu-xrdp-mate-custom/raw/master/SCMonitor-v100-R1-RC2014-08k-ROM.BIN && \ 
    wget -O /opt/rocket2014/SCMonitor-v100-R2-RC2014-16k-ROM.BIN https://github.com/RattyDAVE/docker-ubuntu-xrdp-mate-custom/raw/master/SCMonitor-v100-R2-RC2014-16k-ROM.BIN && \ 
    apt-get -y purge git build-essential qt5-default  && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/*  && \
    \
    mkdir -p /opt/robocode && \
    cd /opt/robocode && \
    wget -O robocode-setup.jar https://downloads.sourceforge.net/project/robocode/robocode/1.9.3.4/robocode-1.9.3.4-setup.jar && \
    unzip robocode-setup.jar && \
    rm robocode-setup.jar && \
    chmod 755 robocode.sh && \
    chmod -R 777 battles compilers roborumble robots && \
    echo "[Desktop Entry]" > /usr/share/applications/robocode.desktop && \
    echo "Name=Robocode" >> /usr/share/applications/robocode.desktop && \
    echo "Comment=Robocode" >> /usr/share/applications/robocode.desktop && \
    echo "Exec=/opt/robocode/robocode.sh" >> /usr/share/applications/robocode.desktop && \
    echo "Terminal=false" >> /usr/share/applications/robocode.desktop && \
    echo "Type=Application" >> /usr/share/applications/robocode.desktop && \
    \
    echo "[Desktop Entry]" > /usr/share/applications/rocket2014.desktop && \
    echo "Name=Rocket2014" >> /usr/share/applications/rocket2014.desktop && \
    echo "Comment=RC2014 Z80 emulator" >> /usr/share/applications/rocket2014.desktop && \
    echo "Exec=/usr/bin/Rocket2014" >> /usr/share/applications/rocket2014.desktop && \
    echo "Terminal=false" >> /usr/share/applications/rocket2014.desktop && \
    echo "Type=Application" >> /usr/share/applications/rocket2014.desktop && \
    echo "[Desktop Entry]" > /etc/xdg/autostart/sysinfo.desktop && \
    echo "Name=SystemInfo" >> /etc/xdg/autostart/sysinfo.desktop && \
    echo "Comment=Put System Info in File" >> /etc/xdg/autostart/sysinfo.desktop && \
    echo "Exec=sysinfo" >> /etc/xdg/autostart/sysinfo.desktop && \
    echo "Terminal=false" >> /etc/xdg/autostart/sysinfo.desktop && \
    echo "Type=Application" >> /etc/xdg/autostart/sysinfo.desktop

COPY sysinfo /usr/bin
RUN chmod 755 /usr/bin/sysinfo
