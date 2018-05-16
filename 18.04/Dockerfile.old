#FROM ubuntu:latest
FROM rattydave/ubuntu-ssh:18.04

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
    apt-get install -y git autoconf libtool pkg-config gcc g++ make  libssl-dev libpam0g-dev libjpeg-dev libx11-dev libxfixes-dev libxrandr-dev  flex bison libxml2-dev intltool xsltproc xutils-dev python-libxml2 g++ xutils libfuse-dev libmp3lame-dev nasm libpixman-1-dev xserver-xorg-dev && \
    cd /root && git clone -b devel https://github.com/neutrinolabs/xrdp.git  && \
    git clone -b devel https://github.com/neutrinolabs/xorgxrdp.git && \ 
    cd /root/xrdp && ./bootstrap && ./configure --enable-jpeg && make && make install && \ 
    cd /root/xorgxrdp  && ./bootstrap && ./configure && make && make install && \ 
    apt-get purge -y git autoconf libtool pkg-config gcc g++ make libssl-dev libpam0g-dev libjpeg-dev libx11-dev libxfixes-dev libxrandr-dev  flex bison libxml2-dev intltool xsltproc xutils-dev python-libxml2 g++ xutils libfuse-dev libmp3lame-dev nasm libpixman-1-dev xserver-xorg-dev && \ 
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
    echo "[Desktop Entry]" > /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Type=Application" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Exec=setxkbmap gb" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Hidden=false" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "X-MATE-Autostart-enabled=true" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Name[C]=SetKeyBoard GB" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Name=SetKeyBoard GB" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Comment[C]=Sets the keyboard to GB" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Comment=Sets the keyboard to GB" >> /etc/xdg/autostart/setxkbmap.desktop

ADD   xrdp.ini /etc/xrdp/xrdp.ini
ADD   km-0809.ini /etc/xrdp/km-0809.ini
RUN   chmod 644 /etc/xrdp/km-0809.ini

ADD startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]
                                    
EXPOSE 3389
