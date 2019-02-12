FROM ubuntu:19.04 as builder

ENV DEBIAN_FRONTEND noninteractive
RUN sed -i "s/# deb-src/deb-src/g" /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -yy upgrade
ENV BUILD_DEPS="git autoconf pkg-config libssl-dev libpam0g-dev \
    libx11-dev libxfixes-dev libxrandr-dev nasm xsltproc flex \
    bison libxml2-dev dpkg-dev libcap-dev"
RUN apt-get -yy install  sudo apt-utils software-properties-common $BUILD_DEPS

WORKDIR /tmp
RUN apt-get source pulseaudio
RUN apt-get build-dep -yy pulseaudio
RUN ls
WORKDIR /tmp/pulseaudio-12.2
RUN dpkg-buildpackage -rfakeroot -uc -b
WORKDIR /tmp
RUN git clone --branch v0.9.7 --recursive https://github.com/neutrinolabs/xrdp.git
WORKDIR /tmp/xrdp
RUN ./bootstrap
RUN ./configure
RUN make
RUN make install
WORKDIR /tmp/xrdp/sesman/chansrv/pulse
RUN sed -i "s/\/tmp\/pulseaudio\-10\.0/\/tmp\/pulseaudio\-12\.2/g" Makefile
RUN make
RUN mkdir -p /tmp/so
RUN cp *.so /tmp/so



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
        uuid-runtime && \
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
    apt-get -y install \
        git \
        libxfont-dev \
        xserver-xorg-core \
        libx11-dev \
        libxfixes-dev \
        libssl-dev \
        libpam0g-dev \
        libtool \
        libjpeg-dev \
        flex \
        bison \
        gettext \
        autoconf \
        libxml-parser-perl \
        libfuse-dev \
        xsltproc \
        libxrandr-dev \
        python-libxml2 \
        nasm \
        xserver-xorg-dev \
        fuse \
        build-essential \
        pkg-config && \
    cd /root && \
    git clone -b devel https://github.com/neutrinolabs/xrdp.git && \
    git clone -b devel https://github.com/neutrinolabs/xorgxrdp.git && \
    cd /root/xrdp && ./bootstrap && ./configure --enable-fuse --enable-jpeg && make && make install && \
    cd /root/xorgxrdp  && ./bootstrap && ./configure && make && make install && \
    rm -R /root/xrdp && \
    rm -R /root/xorgxrdp && \
    apt-get -y purge \
        git \
        libxfont-dev \
        libx11-dev \
        libxfixes-dev \
        libssl-dev \
        libpam0g-dev \
        libtool \
        libjpeg-dev \
        flex \
        bison \
        gettext \
        autoconf \
        libxml-parser-perl \
        libfuse-dev \
        xsltproc \
        libxrandr-dev \
        python-libxml2 \
        nasm \
        xserver-xorg-dev \
        build-essential \
        pkg-config && \
        #        fuse \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/*  && \
    echo "mate-session" > /etc/skel/.xsession && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini  && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini  && \
    sed -i -e '/DisconnectedTimeLimit=/ s/=.*/=300/' /etc/xrdp/sesman.ini && \
    sed -i -e '/IdleTimeLimit=/ s/=.*/=300/' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto  && \
    mkdir -p /var/run/xrdp && \
    chmod 2775 /var/run/xrdp  && \
    mkdir -p /var/run/xrdp/sockdir && \
    chmod 3777 /var/run/xrdp/sockdir && \
    echo "[program:sshd]" >/etc/supervisor/conf.d/sshd.conf && \
    echo "command=/usr/sbin/sshd -D" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "stdout_logfile=/var/log/supervisor/%(program_name)s.log" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "stderr_logfile=/var/log/supervisor/%(program_name)s.log" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "autorestart=true" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "[program:xrdp-sesman]" > /etc/supervisor/conf.d/xrdp.conf && \
    echo "command=/usr/local/sbin/xrdp-sesman --nodaemon" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "process_name = xrdp-sesman" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "[program:xrdp]" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "command=/usr/local/sbin/xrdp -nodaemon" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "process_name = xrdp" >> /etc/supervisor/conf.d/xrdp.conf && \
    mkdir /var/run/dbus && \
    mkdir -p /var/lib/xrdp-pulseaudio-installer

ADD xrdp.ini /etc/xrdp/xrdp.ini
ADD asound.conf /etc/asound.conf

COPY --from=builder /tmp/so/module-xrdp-source.so /var/lib/xrdp-pulseaudio-installer
COPY --from=builder /tmp/so/module-xrdp-sink.so /var/lib/xrdp-pulseaudio-installer

ADD startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]
                                    
EXPOSE 3389

