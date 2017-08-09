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
    libnspr4 libnss3 \
    fonts-liberation \
    libappindicator1 \
    libcurl3 \
    fonts-wqy-microhei \
    firefox \
    remmina* && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    echo "mate-session" > /etc/skel/.xsession && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto

ADD     xrdp.conf /etc/supervisor/conf.d/xrdp.conf
ADD 	km-0809.ini /etc/xrdp/km-0809.ini
RUN 	chown xrdp.xrdp /etc/xrdp/km-0809.ini && \
    chmod 644 /etc/xrdp/km-0809.ini && \
    locale-gen en_GB.UTF-8 && \
    update-locale LANG=en_GB.UTF-8 && \
    ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 3389
