#!/bin/bash

cd /root 
sed -i 's/^#\s*\(deb.*partner\)$/\1/g' /etc/apt/sources.list  

echo 'LANG="en_GB.UTF-8"' > /etc/default/locale 
echo 'LANGUAGE="en_GB:en"' >> /etc/default/locale 
echo 'LC_ALL="en_GB.UTF-8"' >> /etc/default/locale 
locale-gen en_GB.UTF-8  
update-locale LANG=en_GB.UTF-8

apt-add-repository -y ppa:ubuntu-mate-dev/ppa
apt-add-repository -y ppa:ubuntu-mate-dev/trusty-mate
apt-get update -y
apt-get install -y locales

apt-get install -y \
        mate-desktop-environment-core \
        mate-themes \
        xterm \
        ttf-ubuntu-font-family \
        tightvncserver
apt-get install --no-install-recommends -y \
        sudo \
        openssh-server \
        tzdata \
        vim \
        mc \
        ca-certificates \
        curl \
        wget \
        chromium-browser
ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
apt-get -y install \
        git \
        xserver-xorg-core \
        libx11-dev \
        libxfixes-dev \
        libssl-dev \
        libpam0g-dev \
        libtool \
        libjpeg-dev \
        flex \
        bison \
        gettext \
        autoconf \
        libxml-parser-perl \
        libfuse-dev \
        xsltproc \
        libxrandr-dev \
        python-libxml2 \
        nasm \
        xserver-xorg-dev \
        fuse \
        build-essential \
        pkg-config
git clone https://github.com/neutrinolabs/xrdp.git
git clone https://github.com/neutrinolabs/xorgxrdp.git
cd /root/xrdp && ./bootstrap && ./configure --enable-jpeg && make && make install
cd /root/xorgxrdp  && ./bootstrap && ./configure && make && make install

cd /root
git clone https://github.com/jeroennijhof/vncpwd.git
cd vncpwd
make
cp vncpwd /usr/bin 
cd /root
rm -R /root/vncpwd

apt-get -y purge \
        git \
        libxfont1-dev \
        libx11-dev \
        libxfixes-dev \
        libssl-dev \
        libpam0g-dev \
        libtool \
        libjpeg-dev \
        flex \
        bison \
        gettext \
        autoconf \
        libxml-parser-perl \
        libfuse-dev \
        xsltproc \
        libxrandr-dev \
        python-libxml2 \
        nasm \
        xserver-xorg-dev \
        fuse \
        build-essential \
        pkg-config
apt-get -y autoclean && apt-get -y autoremove
apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g)
rm -rf /root/xorgxrdp/ /root/xrdp/
echo "mate-session" > /etc/skel/.xsession
sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini
sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini
xrdp-keygen xrdp auto
update-rc.d xrdp defaults

cd /etc/xrdp
curl -LO https://raw.githubusercontent.com/RattyDAVE/docker-ubuntu-xrdp-mate-custom/master/v2/xrdp.ini
cd /usr/lib/pulse-4.0/modules
curl -LO https://raw.githubusercontent.com/RattyDAVE/docker-ubuntu-xrdp-mate-custom/master/v2/module-xrdp-sink.so
cd /usr/bin
curl -LO https://raw.githubusercontent.com/RattyDAVE/docker-ubuntu-xrdp-mate-custom/master/v2/tools/sysinfo
chmod 755 /usr/bin/sysinfo

echo "[Desktop Entry]" > /etc/xdg/autostart/sysinfo.desktop
echo "Name=SystemInfo" >> /etc/xdg/autostart/sysinfo.desktop
echo "Comment=Put System Info in File" >> /etc/xdg/autostart/sysinfo.desktop
echo "Exec=sysinfo" >> /etc/xdg/autostart/sysinfo.desktop
echo "Terminal=false" >> /etc/xdg/autostart/sysinfo.desktop
echo "Type=Application" >> /etc/xdg/autostart/sysinfo.desktop
