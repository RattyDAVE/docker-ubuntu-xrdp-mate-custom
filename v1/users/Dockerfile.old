FROM rattydave/docker-ubuntu-xrdp-mate-custom:v1

RUN useradd -ms /bin/bash desktop
RUN echo "desktop:desktop" | chpasswd
RUN usermod -aG sudo desktop

RUN mkdir /home_ext
RUN echo HOME=/home_ext >> /etc/default/useradd
RUN useradd -ms /bin/bash --base-dir /home_ext ext_desktop
RUN echo "ext_desktop:desktop" | chpasswd
RUN usermod -aG sudo ext_desktop
