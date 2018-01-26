#FROM ubuntu:latest
FROM rattydave/ubuntu-ssh:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

#apt-get install -yqq \
#        mate-desktop-environment-core \
#        mate-themes \
#        tightvncserver \
#        x11vnc && \ 

## Enable Ubuntu Universe, Multiverse, and deb-src for main.
#RUN sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list
#RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
#RUN sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list
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
        tightvncserver && \
    #apt-get install -y dbus-x11 && \   
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
        libxfont1-dev \
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
    git clone -b devel https://github.com/neutrinolabs/xrdp.git  && \
    git clone -b devel https://github.com/neutrinolabs/xorgxrdp.git && \
    cd /root/xrdp && ./bootstrap && ./configure --enable-jpeg && make && make install  && \
    cd /root/xorgxrdp  && ./bootstrap && ./configure && make && make install  && \
    apt-get -y purge \
        git \
        libxfont1-dev \
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
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/*  && \
    rm -rf /root/xorgxrdp/ /root/xrdp/ && \
    echo "mate-session" > /etc/skel/.xsession && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini  && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini  && \
    xrdp-keygen xrdp auto  && \
    mkdir -p /var/run/xrdp && \
    chmod 2775 /var/run/xrdp  && \
    mkdir -p /var/run/xrdp/sockdir && \
    chmod 3777 /var/run/xrdp/sockdir && \
    cat <<EOF > /etc/supervisor/conf.d/sshd.conf
[program:sshd]
command=/usr/sbin/sshd -D
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
autorestart=true
EOF  && \
    cat <<EOF > /etc/supervisor/conf.d/xrdp.conf
[program:xrdp-sesman]
command=/usr/local/sbin/xrdp-sesman --nodaemon
process_name = xrdp-sesman
[program:xrdp]
command=/usr/local/sbin/xrdp -nodaemon
process_name = xrdp
EOF  && \
    cat <<EOF > /etc/xdg/autostart/setxkbmap.desktop
[Desktop Entry]
Type=Application
Exec=setxkbmap gb
Hidden=false
X-MATE-Autostart-enabled=true
Name[C]=SetKeyBoard GB
Name=SetKeyBoard GB
Comment[C]=Sets the keyboard to GB
Comment=Sets the keyboard to GB
EOF

ADD   xrdp.ini /etc/xrdp/xrdp.ini
ADD   km-0809.ini /etc/xrdp/km-0809.ini
RUN   chmod 644 /etc/xrdp/km-0809.ini

ADD startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]
                                    
EXPOSE 3389
