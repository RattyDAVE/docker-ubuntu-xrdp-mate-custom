FROM rattydave/docker-ubuntu-xrdp-mate-custom:latest

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Dave Pucknell <dave@pucknell.co.uk>

RUN	echo "Start `date`"

# Herculese
# Install requirements

RUN     apt-get update -y

RUN     apt-get install -y \
                nfs-common \
                hercules \
                x3270 \
                c3270 \
                xterm \
                telnet

RUN     apt-get autoclean && apt-get autoremove && \
        rm -rf /var/lib/apt/lists/*
    
RUN     mkdir /mnt/mainframe
RUN     echo nas.lan:mainframe	/mnt/mainframe	nfs4	rw,hard,intr,vers=2,nolock >> /etc/fstab

RUN     usermod -aG sudo desktop

RUN	echo "END `date`"

#CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 22 3270

ADD 	startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]



# hercules -f ./conf/turnkey_mvs.conf
#CMD ["/usr/bin/hercules", "-f", "/mnt/mainframe/mvs38j.davetest/turnkey_mvs.conf"]

# telnet 127.0.0.1 3270

#CMD ["/usr/bin/telnet", "127.0.0.1", "3270"]

# 5x c3270 127.0.0.1:3270

#CMD ["/usr/bin/c3270", "127.0.0.1:3270"]
#CMD ["/usr/bin/c3270", "127.0.0.1:3270"]
#CMD ["/usr/bin/c3270", "127.0.0.1:3270"]
#CMD ["/usr/bin/c3270", "127.0.0.1:3270"]
#CMD ["/usr/bin/c3270", "127.0.0.1:3270"]
