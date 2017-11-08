
cd /root
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
        pkg-config && \
    git clone https://github.com/neutrinolabs/xrdp.git
    git clone https://github.com/neutrinolabs/xorgxrdp.git
    
wget https://freedesktop.org/software/pulseaudio/releases/pulseaudio-$(pulseaudio --version|sed 's/pulseaudio //g').tar.gz
tar xvf pulseaudio*
cd pulseaudio-$(pulseaudio --version|sed 's/pulseaudio //g')

apt-get build-dep pulseaudio
./configure

cd /root/xrdp/sesman/chansrv/pulse
sed -i "s\/tmp/pulseaudio-10.0\/root/pulseaudio-4.0\g" /root/xrdp/sesman/chansrv/pulse/Makefile
make

cp module-xrdp-sink.so /usr/lib/pulse-*/modules

apt-get autoremove $(apt-cache showsrc pulseaudio | sed -e '/Build-Depends/!d;s/Build-Depends: \|,\|([^)]*),*\|\[[^]]*\]//g')


