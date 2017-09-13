FROM ubuntu:latest

#NO USERS ARE ACTIVE!!!!!!!!

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

## Enable Ubuntu Universe, Multiverse, and deb-src for main.
#RUN sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list
#RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
#RUN sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list

RUN     apt-get update -y && \
    apt-get install --no-install-recommends -y \
    locales \
    supervisor \
    tzdata

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
    firefox \
    ca-certificates wget

RUN apt-get install -y \
    xrdp

# Install Google Chrome
#RUN    apt-get install --no-install-recommends -y libxss1 libappindicator1 libindicator7 xdg-utils
#RUN    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#RUN    dpkg -i google-chrome*.deb
#RUN    apt-get install -f

RUN    apt-get autoclean && apt-get autoremove
RUN    rm -rf /var/lib/apt/lists/*

RUN    echo "mate-session" > /etc/skel/.xsession
RUN    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini
RUN    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini
#RUN    sed -i.bak '/fi/a #xrdp multiple users configuration \n mate-session \n' /etc/xrdp/startwm.sh
RUN    xrdp-keygen xrdp auto

ADD     xrdp.conf /etc/supervisor/conf.d/xrdp.conf
ADD 	km-0809.ini /etc/xrdp/km-0809.ini
RUN 	chown xrdp.xrdp /etc/xrdp/km-0809.ini
RUN     chmod 644 /etc/xrdp/km-0809.ini

RUN    locale-gen en_GB.UTF-8
RUN    update-locale LANG=en_GB.UTF-8

RUN    ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 3389
