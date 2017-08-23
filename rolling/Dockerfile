FROM ubuntu:rolling

#NO USERS ARE ACTIVE!!!!!!!!

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

## Enable Ubuntu Universe, Multiverse, and deb-src for main.
#RUN sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list
#RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
#RUN sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list
RUN sed -i 's/^#\s*\(deb.*partner\)$/\1/g' /etc/apt/sources.list

RUN apt-get update -y

RUN apt-get install -yqq\    
    locales

# Fix locale
RUN echo 'LANG="en_GB.UTF-8"' > /etc/default/locale
RUN echo 'LANGUAGE="en_GB:en"' >> /etc/default/locale
RUN echo 'LC_ALL="en_GB.UTF-8"' >> /etc/default/locale
RUN    locale-gen en_GB.UTF-8
RUN    update-locale LANG=en_GB.UTF-8
#RUN sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'GB'\"/g' /etc/default/keyboard
#RUN echo "setxkbmap gb" > /etc/profile.d/setxkbmap.sh
#RUN sed -i s/us/gb/g /etc/default/keyboard

RUN apt-get install --no-install-recommends -yqq \
    supervisor \
    tzdata

RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

#RUN apt-get install -y \
#    mate-core \
#    mate-desktop-environment \
#    mate-notification-daemon

RUN apt-get install -yqq \
    tightvncserver \
    vnc4server \
    x11vnc \
    xrdp \
    mate-desktop-environment \
    mate-themes
    
#RUN apt-get install -y \
#    gconf-service \
#    libnspr4 \
#    libnss3 \
#    fonts-liberation \
#    libappindicator1 \
#    libcurl3 \
#    fonts-wqy-microhei
    
RUN apt-get install --no-install-recommends -yqq \
    openssh-server \
    firefox \
    vim \
    mc \
    ca-certificates \
    wget
    
RUN    apt-get autoclean && apt-get autoremove
RUN    rm -rf /var/lib/apt/lists/*

RUN    echo "mate-session" > /etc/skel/.xsession
RUN    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini
RUN    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini

RUN    xrdp-keygen xrdp auto

#Taken From  /usr/share/xrdp/socksetup
RUN mkdir -p /var/run/xrdp
RUN chown root:xrdp /var/run/xrdp
RUN chmod 2775 /var/run/xrdp

RUN mkdir -p /var/run/xrdp/sockdir
RUN chown root:xrdp /var/run/xrdp/sockdir
RUN chmod 3777 /var/run/xrdp/sockdir
#--------

ADD     sshd.conf /etc/supervisor/conf.d/sshd.conf
RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd

ADD     xrdp.conf /etc/supervisor/conf.d/xrdp.conf
#ADD 	km-0809.ini /etc/xrdp/km-0809.ini
#RUN 	chown xrdp.xrdp /etc/xrdp/km-0809.ini
#RUN     chmod 644 /etc/xrdp/km-0809.ini

ADD setxkbmap.desktop /etc/xdg/autostart/setxkbmap.desktop
RUN rm /etc/xdg/autostart/mate-*.desktop

CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 3389 22
