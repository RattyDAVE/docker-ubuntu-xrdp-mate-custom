FROM rigormortiz/ubuntu-xrdp-mate:latest

MAINTAINER Dave Pucknell <dave@pucknell.co.uk>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

RUN 	apt-get update -y && \
	apt-get install -y tzdata pwgen && \ 
	apt-get autoclean && apt-get autoremove && \
 	rm -rf /var/lib/apt/lists/* 

RUN 	

	useradd -ms /bin/bash user1 && \
	echo user1:password1|chpasswd && \
	useradd -ms /bin/bash user2 && \
	echo user2:password2|chpasswd && \
	usermod -aG sudo user2 && \
	echo "mate-session" > /home/user1/.xsession && \
	echo "mate-session" > /home/user2/.xsession && \
	echo "END"


ADD startup.sh /root/startup.sh

ADD km-0809.ini /etc/xrdp/km-0809.ini
RUN chown xrdp.xrdp /etc/xrdp/km-0809.ini
RUN chmod 644 /etc/xrdp/km-0809.ini
                                 
# Set the locale
RUN locale-gen en_GB.UTF-8
RUN update-locale LANG=en_GB.UTF-8
RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 3389

CMD ["/bin/bash", "/root/startup.sh"]
