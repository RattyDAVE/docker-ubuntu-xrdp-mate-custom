FROM rattydave/docker-ubuntu-xrdp-mate-custom:core

RUN useradd -ms /bin/bash desktop && \
    echo "desktop:desktop" | chpasswd && \
    usermod -aG sudo desktop  && \
    mkdir /home_ext && \
    echo HOME=/home_ext >> /etc/default/useradd && \
    useradd -ms /bin/bash --base-dir /home_ext ext_desktop && \
    echo "ext_desktop:desktop" | chpasswd && \
    usermod -aG sudo ext_desktop
