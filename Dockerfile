#FROM rigormortiz/ubuntu-supervisor:0.1
#FROM ubuntu:zesty
FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Dave Pucknell <dave@pucknell.co.uk>
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

RUN	echo "Start `date`"

RUN apt-get update -y && \
    apt-get install -y \
    locales supervisor tzdata mate-core xrdp \
    mate-desktop-environment mate-notification-daemon \
    gconf-service libnspr4 libnss3 fonts-liberation \
    libappindicator1 libcurl3 fonts-wqy-microhei firefox \
    remmina* \
    && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -ms /bin/bash desktop && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto && \
    echo "desktop:desktop" | chpasswd && \
    usermod -aG sudo desktop && \
    echo "mate-session" > /home/desktop/.xsession

ADD     xrdp.conf /etc/supervisor/conf.d/xrdp.conf
ADD 	km-0809.ini /etc/xrdp/km-0809.ini
RUN 	chown xrdp.xrdp /etc/xrdp/km-0809.ini
RUN 	chmod 644 /etc/xrdp/km-0809.ini
                                 
# Set the locale
RUN 	locale-gen en_GB.UTF-8
RUN 	update-locale LANG=en_GB.UTF-8
RUN 	ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

RUN	echo "END `date`"

CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 3389

# CMD ["/bin/bash", "/root/startup.sh"]
