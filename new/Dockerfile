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
    
 RUN apt-get install --no-install-recommends -yqq \   
    openssh-server \
    chromium-browser \
    vim \
    mc \
    ca-certificates \
    xterm \
    curl \
    filezilla \
    netbeans \
    dia \
    geany \
    putty \
    mysql-workbench \
    wget \
    caja-dropbox \
    remmina* \
    dos2unix \
    libreoffice
    
#RUN apt-get install -y \
#    gconf-service \
#    libnspr4 \
#    libnss3 \
#    fonts-liberation \
#    libappindicator1 \
#    libcurl3 \
#    fonts-wqy-microhei
    
#RUN apt-get install --no-install-recommends -yqq \
#    openssh-server \
#    chromium-browser \
#    vim \
#    mc \
#    ca-certificates \
#    wget


WORKDIR /root
RUN    wget --no-check-certificate https://go.skype.com/skypeforlinux-64.deb
RUN    apt-get install -yqq apt-transport-https
RUN    dpkg -i skypeforlinux-64.deb; apt-get install -f -yqq

RUN wget http://www.bluej.org/download/files/BlueJ-linux-410.deb
RUN apt-get install -yqq openjdk-9-jre
RUN dpkg -i BlueJ-linux-410.deb; apt-get install -f -y
    
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

#ADD     sshd.conf /etc/supervisor/conf.d/sshd.conf

RUN echo "[program:sshd]" >/etc/supervisor/conf.d/sshd.conf && \
    echo "command=/usr/sbin/sshd -D" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "stdout_logfile=/var/log/supervisor/%(program_name)s.log" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "stderr_logfile=/var/log/supervisor/%(program_name)s.log" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "autorestart=true" >> /etc/supervisor/conf.d/sshd.conf


RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd

#ADD     xrdp.conf /etc/supervisor/conf.d/xrdp.conf

RUN echo "[program:xrdp-sesman]" > /etc/supervisor/conf.d/xrdp.conf && \
    echo "command=/usr/sbin/xrdp-sesman --nodaemon" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "process_name = xrdp-sesman" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "[program:xrdp] >> /etc/supervisor">> /etc/supervisor/conf.d/xrdp.conf && \
    echo "command=/usr/sbin/xrdp -nodaemon" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "process_name = xrdp" >> /etc/supervisor/conf.d/xrdp.conf

ADD 	km-0809.ini /etc/xrdp/km-0809.ini
RUN 	chown xrdp.xrdp /etc/xrdp/km-0809.ini
RUN     chmod 644 /etc/xrdp/km-0809.ini

#ADD setxkbmap.desktop /etc/xdg/autostart/setxkbmap.desktop
RUN echo "[Desktop Entry]" > /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Type=Application" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Exec=setxkbmap gb" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Hidden=false" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "X-MATE-Autostart-enabled=true" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Name[C]=SetKeyBoard GB" > /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Name=SetKeyBoard GB" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Comment[C]=Sets the keyboard to GB" >> /etc/xdg/autostart/setxkbmap.desktop && \
    echo "Comment=Sets the keyboard to GB" >> /etc/xdg/autostart/setxkbmap.desktop

#RUN rm /etc/xdg/autostart/mate-*.desktop


# USERS ARE NOW HANDLED BY STARTUP SCRIPT.
#RUN useradd -ms /bin/bash desktop
#RUN echo "desktop:desktop" | chpasswd
#RUN usermod -aG sudo desktop

#RUN mkdir /home_ext
#RUN echo HOME=/home_ext >> /etc/default/useradd
#RUN useradd -ms /bin/bash --base-dir /home_ext ext_desktop
#RUN echo "ext_desktop:desktop" | chpasswd
#RUN usermod -aG sudo ext_desktop

RUN cp /etc/hosts /etc/hosts.ori

# CMD ["/usr/bin/supervisord", "-n"]
ADD startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]
                                    
EXPOSE 3389 22
