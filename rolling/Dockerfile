FROM ubuntu:rolling

#NO USERS ARE ACTIVE!!!!!!!!

ENV DEBIAN_FRONTEND noninteractive
#ENV LANG en_GB.UTF-8
#ENV LANGUAGE en_GB:GB
#ENV LC_ALL en_GB.UTF-8

## Enable Ubuntu Universe, Multiverse, and deb-src for main.
#RUN sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list
#RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
#RUN sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    supervisor \
    tzdata
#    locales \


RUN apt-get install -y \
    mate-core \
    mate-desktop-environment \
    mate-notification-daemon
    
RUN apt-get install -y \
    gconf-service \
    libnspr4 \
    libnss3 \
    fonts-liberation \
    libappindicator1 \
    libcurl3 \
    fonts-wqy-microhei
    
RUN apt-get install --no-install-recommends -y \
    openssh-server \
    firefox \
    vim \
    mc \
    ca-certificates wget
        
RUN apt-get install -y \
    tightvncserver \
    xrdp
    
# Install Google Chrome
#RUN    apt-get install --no-install-recommends -y libxss1 libappindicator1 libindicator7 xdg-utils
#RUN    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#RUN    dpkg -i google-chrome*.deb
#RUN    apt-get install -f

# Install Skype
#RUN    apt-get install --no-install-recommends -y libxss1 libappindicator1 libindicator7 xdg-utils
#RUN    wget --no-check-certificate https://go.skype.com/skypeforlinux-64.deb
#RUN    apt-get install -y apt-transport-https
#RUN    dpkg -i skypeforlinux-64.deb
#RUN    apt-get install -f

RUN    apt-get autoclean && apt-get autoremove
RUN    rm -rf /var/lib/apt/lists/*

RUN    echo "mate-session" > /etc/skel/.xsession
RUN    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini
RUN    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini

#Not needed CHECKED!
#RUN    sed -i.bak '/fi/a #xrdp multiple users configuration \n mate-session \n' /etc/xrdp/startwm.sh
#--------

RUN    xrdp-keygen xrdp auto

#Not needed CHECKED!
#RUN mkdir -p /var/run/dbus
#RUN chown messagebus:messagebus /var/run/dbus
#RUN dbus-uuidgen --ensure
#--------

#Not needed CHECKED!
#RUN echo "[program:dbus-daemon]" >> /etc/supervisor/conf.d/dbus.conf
#RUN echo "command=/usr/bin/dbus-daemon --system --nofork" >> /etc/supervisor/conf.d/dbus.conf
#RUN echo "user=messagebus" >> /etc/supervisor/conf.d/dbus.conf
#--------

#Taken From  /usr/share/xrdp/socksetup
RUN mkdir -p /var/run/xrdp
RUN chown root:xrdp /var/run/xrdp
RUN chmod 2775 /var/run/xrdp

RUN mkdir -p /var/run/xrdp/sockdir
RUN chown root:xrdp /var/run/xrdp/sockdir
RUN chmod 3777 /var/run/xrdp/sockdir
#--------

#Not needed CHECKED!
#RUN    /etc/init.d/xrdp start
#RUN    /etc/init.d/xrdp stop
#--------

ADD     sshd.conf /etc/supervisor/conf.d/sshd.conf
RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd

#ADD     xrdp.conf /etc/supervisor/conf.d/xrdp.conf
#ADD 	km-0809.ini /etc/xrdp/km-0809.ini
#RUN 	chown xrdp.xrdp /etc/xrdp/km-0809.ini
#RUN     chmod 644 /etc/xrdp/km-0809.ini

RUN echo "setxkbmap gb" > /etc/profile.d/setxkbmap.sh
RUN sed -i s/us/gb/g /etc/default/keyboard

#RUN    locale-gen en_GB.UTF-8
#RUN    update-locale LANG=en_GB.UTF-8

RUN    ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 3389 22
