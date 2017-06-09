#FROM rigormortiz/ubuntu-supervisor:0.1
#FROM ubuntu:zesty
FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Dave Pucknell <dave@pucknell.co.uk>
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

RUN	echo "Start `date`"

RUN apt-get update -y && \
    apt-get install -y \
    locales supervisor tzdata mate-core xrdp \
    mate-desktop-environment mate-notification-daemon \
    gconf-service libnspr4 libnss3 fonts-liberation \
    libappindicator1 libcurl3 fonts-wqy-microhei firefox && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -ms /bin/bash desktop && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto && \
    echo "desktop:desktop" | chpasswd && \
    echo "mate-session" > /home/desktop/.xsession

ADD     xrdp.conf /etc/supervisor/conf.d/xrdp.conf
ADD 	km-0809.ini /etc/xrdp/km-0809.ini
RUN 	chown xrdp.xrdp /etc/xrdp/km-0809.ini
RUN 	chmod 644 /etc/xrdp/km-0809.ini
                                 
# Set the locale
RUN 	locale-gen en_GB.UTF-8
RUN 	update-locale LANG=en_GB.UTF-8
RUN 	ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# X2go
# Install requirements
RUN apt-get install -y \
        software-properties-common \
        openssh-server

# Install X2Go server components
RUN add-apt-repository ppa:x2go/stable
RUN apt-get update -y
RUN apt-get install -y x2goserver

# SSH runtime
RUN mkdir /var/run/sshd

#Configure root password
RUN echo "root:SuperSecureRootPassword" | chpasswd

# Configure default user
RUN adduser --gecos "X2go User" --home /home/x2go --disabled-password x2go
RUN echo "x2go:x2go" | chpasswd

#Desktop Note with credits
RUN mkdir /home/x2go/Desktop
RUN chown x2go:x2go /home/x2go/Desktop
RUN touch /home/x2go/Desktop/README.txt
RUN echo -e "To give the user sudo access, run 'su' and use the password 'SuperSecureRootPassword' (You will be told to change this) and then use 'usermod -aG sudo x2go'.\nEnjoy!\n\nThis script was based on the work of https://github.com/bigbrozer - Check out his Github!" | tee /home/x2go/Desktop/README.txt
RUN chown x2go:x2go /home/x2go/Desktop/README.txt && chmod 777 /home/x2go/Desktop/README.txt

ADD     sshd.conf /etc/supervisor/conf.d/sshd.conf

RUN	echo "END `date`"

CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 3389 22

# CMD ["/bin/bash", "/root/startup.sh"]
