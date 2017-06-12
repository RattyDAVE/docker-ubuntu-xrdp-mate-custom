FROM rattydave/docker-ubuntu-xrdp-mate-custom

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Dave Pucknell <dave@pucknell.co.uk>

RUN	echo "Start `date`"

# Herculese
# Install requirements

RUN     apt-get update -y

RUN     apt-get install -y \
                nfs-common \
                hercules \
                x3270

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
