FROM rattydave/docker-ubuntu-xrdp-mate-custom:core

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Dave Pucknell <dave@pucknell.co.uk>

RUN	echo "Start `date`"

RUN useradd -ms /bin/bash desktop && \
    echo "desktop:desktop" | chpasswd && \
    usermod -aG sudo desktop
    
#Change default Home directory to out of container storage. 
RUN mkdir /home_ext
RUN echo HOME=/home_ext >> /etc/default/useradd

RUN useradd -ms /bin/bash desktop && \
    echo "ext_desktop:desktop" | chpasswd && \
    usermod -aG sudo ext_desktop


RUN	echo "END `date`"
