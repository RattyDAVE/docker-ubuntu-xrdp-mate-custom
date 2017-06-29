FROM ubuntu:latest

#NO USERS ARE ACTIVE!!!!!!!!

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Dave Pucknell <dave@pucknell.co.uk>
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

RUN	echo "Start `date`"

RUN apt-get update -y && \
    apt-get install -y \
    locales supervisor tzdata mate-core \
    mate-desktop-environment mate-notification-daemon \
    gconf-service libnspr4 libnss3 fonts-liberation \
    libappindicator1 libcurl3 fonts-wqy-microhei firefox \
    remmina* git wget

RUN cd /tmp \
    && git clone -b devel https://github.com/scarygliders/X11RDP-o-Matic.git \
    && git clone https://github.com/scarygliders/X11RDP-o-Matic.git \
    && wget -O /tmp/X11RDP-o-Matic/DEV-X11rdp-o-matic.sh https://www.dropbox.com/s/obrg90m4djhb2ct/DEV-X11rdp-o-matic.sh \
    && chmod +x /tmp/X11RDP-o-Matic/*.sh \
    && apt-get -y install dh-make gdebi autoconf dh-systemd libfuse-dev libjpeg-dev libopus-dev libpam0g-dev libssl-dev libtool libtool-bin nasm xserver-xorg-dev flex bison libxml2-dev intltool xsltproc xutils-dev xutils dialog checkinstall x11proto-dmx-dev x11proto-xf86dga-dev x11proto-bigreqs-dev x11proto-record-dev x11proto-xf86vidmode-dev x11proto-xcmisc-dev libx11-xcb-dev libxcb-dri2-0-dev libxcb-dri3-dev libxcb-glx0-dev libxcb-present-dev libxcb-randr0-dev libxcb-shape0-dev libxcb-sync-dev libxcb-xfixes0-dev libxshmfence-dev libxxf86vm-dev libwinpr-asn1-0.1 libwinpr-bcrypt0.1 libwinpr-credentials0.1 libwinpr-credui0.1 libwinpr-dev libwinpr-error0.1 libwinpr-io0.1 libwinpr-pipe0.1 libwinpr-sspicli0.1 libwinpr-timezone0.1 libwinpr-winhttp0.1 libwinpr-winsock0.1 libxfreerdp-client1.1 libavahi-client-dev libavahi-common-dev

RUN cd /tmp/X11RDP-o-Matic/ \
    && ./DEV-X11rdp-o-matic.sh --nocpuoptimize --justdoit --withsound --withkerberos --withpamuserpass --withfreerdp --withjpeg --withsimplesound --withpulse

# Fetch the pulseaudio source code. Run the build (even when not installing it) otherwise the compilation of the xrdp pulseaudio sink module will fail.
RUN apt-get -y build-dep pulseaudio
RUN cd /tmp && apt-get -y source pulseaudio && cd /tmp/pulseaudio-* && dpkg-buildpackage -us -uc -rfakeroot

RUN cd /tmp/ \
    && git clone -b master https://github.com/neutrinolabs/xrdp.git \
    && cd /tmp/xrdp/sesman/chansrv/pulse/ \
    && make PULSE_DIR=$(find /tmp -maxdepth 1 -type d -name 'pulseaudio-*' | head -1) \
    && cp module-xrdp-sink.so module-xrdp-source.so $(dpkg -L pulseaudio | grep -e 'modules$')/ \
    && rm -rf /tmp/pulseaudio-* /tmp/xrdp/

RUN    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    echo "mate-session" > /etc/skel/.xsession && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto

# Supervisord
RUN echo "[supervisord]\nnodaemon=true\n" > /etc/supervisor/conf.d/supervisord.conf
RUN echo "[program:xrdp]\ncommand=/usr/sbin/xrdp --nodaemon\n" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "[program:xrdp-sesman]\ncommand=/usr/sbin/xrdp-sesman -n\n" >> /etc/supervisor/conf.d/supervisord.conf

#ADD 	km-0809.ini /etc/xrdp/km-0809.ini
#RUN 	chown xrdp.xrdp /etc/xrdp/km-0809.ini
#RUN 	chmod 644 /etc/xrdp/km-0809.ini
                                 
# Set the locale
RUN 	locale-gen en_GB.UTF-8
RUN 	update-locale LANG=en_GB.UTF-8
RUN 	ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

RUN	echo "END `date`"

CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 3389

# CMD ["/bin/bash", "/root/startup.sh"]
