#FROM rigormortiz/ubuntu-supervisor:0.1
#FROM ubuntu:zesty
FROM rattydave/docker-ubuntu-xrdp-mate-custom

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Dave Pucknell <dave@pucknell.co.uk>

RUN	echo "Start `date`"

# X2go
# Install requirements

RUN apt-get update -y

RUN apt-get install -y \
        software-properties-common \
        openssh-server
        

# Install X2Go server components
RUN add-apt-repository ppa:x2go/stable
RUN apt-get update -y
RUN apt-get install -y x2goserver

RUN apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

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

ADD sshd.conf /etc/supervisor/conf.d/sshd.conf

RUN	echo "END `date`"

CMD ["/usr/bin/supervisord", "-n"]
                                    
EXPOSE 22

# CMD ["/bin/bash", "/root/startup.sh"]
