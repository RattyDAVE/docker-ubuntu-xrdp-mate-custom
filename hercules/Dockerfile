FROM rattydave/docker-ubuntu-xrdp-mate-custom

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Dave Pucknell <dave@pucknell.co.uk>

RUN	echo "Start `date`"

# Herculese
# Install requirements

RUN apt-get update -y

RUN apt-get install -y \
        nfs-common \
        hercules

RUN apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*
    
RUN mkdir /mnt/mainframe


RUN	echo "END `date`"

CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 22 3370

# CMD ["/bin/bash", "/root/startup.sh"]
