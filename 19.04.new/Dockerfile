FROM ubuntu:19.04

ENV DEBIAN_FRONTEND noninteractive
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

RUN cd /root && \
    sed -i 's/^#\s*\(deb.*partner\)$/\1/g' /etc/apt/sources.list && \
    apt-get update -y && \ 
    apt-get install -yqq locales  && \ 
    echo 'LANG="en_GB.UTF-8"' > /etc/default/locale && \ 
    echo 'LANGUAGE="en_GB:en"' >> /etc/default/locale && \ 
    echo 'LC_ALL="en_GB.UTF-8"' >> /etc/default/locale && \ 
    locale-gen en_GB.UTF-8 && \ 
    update-locale LANG=en_GB.UTF-8  && \ 
    apt-get install -yqq \
        mate-desktop-environment-core \
        mate-themes \
        mate-accessibility-profiles \
        mate-applet-appmenu \
        mate-applet-brisk-menu \
        mate-applets \
        mate-applets-common \
        mate-calc \
        mate-calc-common \
        mate-dock-applet \
        mate-hud \
        mate-indicator-applet \
        mate-indicator-applet-common \
        mate-menu \
        mate-notification-daemon \
        mate-notification-daemon-common \
        mate-utils \
        mate-utils-common \
        mate-window-applets-common \
        mate-window-buttons-applet \
        mate-window-menu-applet \
        mate-window-title-applet \
        ubuntu-mate-icon-themes \
        ubuntu-mate-themes \
        tightvncserver \
        pulseaudio \
        pavumeter \
        chromium-browser \
        xrdp \
        xorgxrdp \
        uuid-runtime && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/* 
    
RUN  apt-get update -y && \ 
     apt-get install --no-install-recommends -yqq \
        supervisor \
        sudo \
        tzdata \
        vim \
        mc \
        ca-certificates \
        xterm \
        curl \
        wget \
        epiphany-browser && \
    ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/* 
    
#RUN echo "START BUILD" && \
    #apt-get update -yqq && \ 
    #apt-get -y install \
    #    git \
    #    libxfont-dev \
    #    xserver-xorg-core \
    #    libx11-dev \
    #    libxfixes-dev \
    #    libssl-dev \
    #    libpam0g-dev \
    #    libtool \
    #    libjpeg-dev \
    #    flex \
    #    bison \
    #    gettext \
    #    autoconf \
    #    libxml-parser-perl \
    #    libfuse-dev \
    #    xsltproc \
    #    libxrandr-dev \
    #    python-libxml2 \
    #    nasm \
    #   xserver-xorg-dev \
    #    fuse \
    #    build-essential \
    #    libmp3lame-dev \
    #    libavformat-dev \
    #    pkg-config && \
    #cd /root && \
    #git clone -b devel https://github.com/neutrinolabs/xrdp.git && \
    #git clone -b devel https://github.com/neutrinolabs/xorgxrdp.git && \
    #cd /root/xrdp && ./bootstrap && \
    #./configure --enable-fuse --enable-jpeg  --enable-mp3lame --enable-pixman --enable-sound  && \
    #make -j4 && make install && \
    #cd /root/xorgxrdp  && ./bootstrap && ./configure && make && make install && \
    #rm -R /root/xrdp && \
    #rm -R /root/xorgxrdp && \
    #apt-get -y purge \
    #    git \
    #    libxfont-dev \
    #    libx11-dev \
    #    libxfixes-dev \
    #    libssl-dev \
    #    libpam0g-dev \
    #    libtool \
    #    libjpeg-dev \
    #    flex \
    #    bison \
    #    gettext \
    #    autoconf \
    #    libxml-parser-perl \
    #    libfuse-dev \
    #    xsltproc \
    #    libxrandr-dev \
    #    python-libxml2 \
    #    nasm \
    #    xserver-xorg-dev \
    #    build-essential \
    #    pkg-config && \
    #    #        fuse \
    #apt-get -y autoclean && apt-get -y autoremove && \
    #apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    #rm -rf /var/lib/apt/lists/*  && \
    #echo "END BUILD"
    
    
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini  && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini  && \
    sed -i -e '/DisconnectedTimeLimit=/ s/=.*/=300/' /etc/xrdp/sesman.ini && \
    sed -i -e '/IdleTimeLimit=/ s/=.*/=300/' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto  && \
    mkdir -p /var/run/xrdp && \
    chmod 2775 /var/run/xrdp  && \
    mkdir -p /var/run/xrdp/sockdir && \
    chmod 3777 /var/run/xrdp/sockdir && \
    mkdir /var/run/dbus && \
    chmod 3777 /var/run/dbus

COPY /filesystem /

CMD ["/bin/bash", "/root/startup.sh"]
                                    
EXPOSE 3389

