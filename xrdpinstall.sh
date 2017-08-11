 apt-get install -y unzip wget

 mkdir /tmp/xrdpinst
 cd /tmp/xrdpinst

 wget https://github.com/neutrinolabs/xrdp/archive/master.zip
 unzip master.zip
 apt-get -y install autoconf libtool libpam0g-dev libx11-dev libxfixes-dev libssl-dev libxrandr-dev
 apt-get -y install mate-core mate-desktop-environment mate-notification-daemon --force-yes
 apt-get -y install x11vnc
 apt-get -y install xrdp
 apt-get -y remove xrdp

 cd xrdp-master
 
 sed -i.bak 's/which libtool/which libtoolize/g' bootstrap

 ./bootstrap
 ./configure
 make
 make install

 sed -i.bak '/\[xrdp1\]/i [xrdp0] \nname=Xvnc-Sesman-Griffon \nlib=libvnc.so \nusername=ask \npassword=ask \nip=127.0.0.1 \nport=-1 \ndelay_ms=2000' /etc/xrdp/xrdp.ini

 mv /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.backup
 ln -s /etc/X11/Xsession /etc/xrdp/startwm.sh
 mkdir /usr/share/doc/xrdp
 cp /etc/xrdp/rsakeys.ini /usr/share/doc/xrdp/rsakeys.ini
