FROM ubuntu:20.04

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
    update-locale LANG=en_GB.UTF-8

RUN apt-get install -y apt-utils
#RUN apt-get install -y udisks2
#RUN apt-get install -y gvfs-daemons
#RUN apt-get install -y gvfs-backends
#RUN apt-get install -y gvfs:amd64
#RUN apt-get install -y caja


#RUN apt-get install -y mate-desktop-environment-core
RUN apt-get install -y mate-desktop
##RUN apt-get install -y mate-themes
##RUN apt-get install -y mate-accessibility-profiles
##RUN apt-get install -y mate-applet-appmenu
#RUN apt-get install -y mate-applet-brisk-menu
#RUN apt-get install -y mate-applets
#RUN apt-get install -y mate-applets-common
##RUN apt-get install -y mate-calc
##RUN apt-get install -y mate-calc-common
##RUN apt-get install -y mate-dock-applet
RUN apt-get install -y mate-hud
RUN apt-get install -y mate-indicator-applet
RUN apt-get install -y mate-indicator-applet-common
RUN apt-get install -y mate-menu
RUN apt-get install -y mate-notification-daemon
RUN apt-get install -y mate-notification-daemon-common
##RUN apt-get install -y mate-utils
##RUN apt-get install -y mate-utils-common
##RUN apt-get install -y mate-window-applets-common
##RUN apt-get install -y mate-window-buttons-applet
##RUN apt-get install -y mate-window-menu-applet
##RUN apt-get install -y mate-window-title-applet
##RUN apt-get install -y ubuntu-mate-icon-themes
##RUN apt-get install -y ubuntu-mate-themes
RUN apt-get install -y xrdp
RUN apt-get install -y xorgxrdp
##RUN apt-get install -y tightvncserver

RUN apt-get install --no-install-recommends -yqq \
        supervisor \
        sudo \
        tzdata \
        vim \
        mc \
        ca-certificates \
        xterm \
        curl \
        wget \
        epiphany-browser

RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/*  && \
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
    echo "command=/usr/sbin/xrdp-sesman --nodaemon" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "process_name = xrdp-sesman" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "[program:xrdp]" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "command=/usr/sbin/xrdp -nodaemon" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "process_name = xrdp" >> /etc/supervisor/conf.d/xrdp.conf

ADD   xrdp.ini /etc/xrdp/xrdp.ini

ADD startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]
                                    
EXPOSE 3389
