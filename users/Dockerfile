FROM rattydave/docker-ubuntu-xrdp-mate-custom:core

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Dave Pucknell <dave@pucknell.co.uk>

RUN	echo "Start `date`"

RUN useradd -ms /bin/bash desktop && \
    echo "desktop:desktop" | chpasswd && \
    usermod -aG sudo desktop

RUN	echo "END `date`"
