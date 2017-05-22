FROM ubuntu:zesty

MAINTAINER Dave Pucknell <dave@pucknell.co.uk>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

RUN apt-get update -y && \
apt-get install -y supervisor tzdata mate-core \
    mate-desktop-environment mate-notification-daemon \
    gconf-service libnspr4 libnss3 fonts-liberation \
    libappindicator1 libcurl3 fonts-wqy-microhei firefox  && \
apt-get autoclean && apt-get autoremove && \
rm -rf /var/lib/apt/lists/* && \
echo "mate-session" > /home/desktop/.xsession && \
localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8 && \
sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
xrdp-keygen xrdp auto && \
useradd -ms /bin/bash user1 && \
echo user1:password1|chpasswd && \
useradd -ms /bin/bash user2 && \
echo user2:password2|chpasswd && \
usermod -aG sudo user2
     
ADD xrdp.conf /etc/supervisor/conf.d/xrdp.conf     
ADD km-0809.ini /etc/xrdp/km-0809.ini

RUN chown xrdp.xrdp /etc/xrdp/km-0809.ini
RUN chmod 644 /etc/xrdp/km-0809.ini
                                 
# Set the locale
RUN locale-gen en_GB.UTF-8
RUN update-locale LANG=en_GB.UTF-8
RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 3389
