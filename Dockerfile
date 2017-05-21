FROM rigormortiz/ubuntu-xrdp-mate

MAINTAINER Dave Pucknell <dave@pucknell.co.uk>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

RUN apt-get update -y && \
apt-get install -y tzdata && \
apt-get autoclean && apt-get autoremove && \
rm -rf /var/lib/apt/lists/* && \
localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8 && \
useradd -ms /bin/bash myles && \
echo user1:password1|chpasswd && \
useradd -ms /bin/bash dave && \
echo user2:password2|chpasswd && \
usermod -aG sudo user1
                                    
ADD km-0809.ini /etc/xrdp/km-0809.ini
RUN chown xrdp.xrdp /etc/xrdp/km-0809.ini
RUN chmod 644 /etc/xrdp/km-0809.ini
                                 
# Set the locale
RUN locale-gen en_GB.UTF-8
RUN update-locale LANG=en_GB.UTF-8
RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
                                    
EXPOSE 3389
