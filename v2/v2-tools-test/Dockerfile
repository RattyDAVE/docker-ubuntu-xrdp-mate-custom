FROM rattydave/docker-ubuntu-xrdp-mate-custom:v2-tools

RUN apt-get update -y && \ 
    apt-get install -yqq \
      lxdm && \
    echo "[program:lxdm]" >/etc/supervisor/conf.d/lxdm.conf && \
    echo "command=/usr/sbin/lxdm-binary -d" >> /etc/supervisor/conf.d/lxdm.conf && \
    echo "autorestart=true" >> /etc/supervisor/conf.d/lxdm.conf && \ 
    echo ""  >> /etc/lxdm/lxdm.conf && \
    echo "[VNCServer]" >> /etc/lxdm/lxdm.conf && \
    echo "enabled=true" >> /etc/lxdm/lxdm.conf && \
    echo "command=Xvnc -rfbauth /etc/vncpasswd" >> /etc/lxdm/lxdm.conf  && \
    echo "port=5900" >> /etc/lxdm/lxdm.conf && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 5900
