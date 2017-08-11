FROM ubuntu:latest

#NO USERS ARE ACTIVE!!!!!!!!

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

## Enable Ubuntu Universe, Multiverse, and deb-src for main.
RUN sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list
RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
RUN sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list

RUN     apt-get update -y && \
    apt-get install -y \
    locales \
    supervisor \
    tzdata \
    xrdp \
    mate-core \
    mate-desktop-environment \
    mate-notification-daemon \
    gconf-service \
    libnspr4 \
    libnss3 \
    fonts-liberation \
    libappindicator1 \
    libcurl3 \
    fonts-wqy-microhei \
    firefox \
    wget \
    remmina*

# Install Google Chrome
RUN    apt-get install libxss1 libappindicator1 libindicator7
RUN    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN    dpkg -i google-chrome*.deb

RUN    apt-get install -f

RUN    apt-get autoclean && apt-get autoremove
RUN    rm -rf /var/lib/apt/lists/*

RUN    echo "mate-session" > /etc/skel/.xsession
RUN    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini
RUN    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini
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
