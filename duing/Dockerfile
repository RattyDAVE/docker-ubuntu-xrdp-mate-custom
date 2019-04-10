FROM rattydave/ubuntu-ssh:18.10

ENV DEBIAN_FRONTEND noninteractive
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:GB
ENV LC_ALL en_GB.UTF-8

RUN cd /root && \
    sed -i 's/^#\s*\(deb.*partner\)$/\1/g' /etc/apt/sources.list && \ 
    apt-get update -y && \ 
    apt-get install -yqq locales  && \ 
    echo 'LANG="en_GB.UTF-8"' > /etc/default/locale && \ 
    echo 'LANGUAGE="en_GB:en"' >> /etc/default/locale && \ 
    echo 'LC_ALL="en_GB.UTF-8"' >> /etc/default/locale && \ 
    locale-gen en_GB.UTF-8 && \ 
    update-locale LANG=en_GB.UTF-8  && \ 
    apt-get install -yqq \
        mate-desktop-environment-core \
        mate-themes \
        mate-accessibility-profiles \
        mate-applet-appmenu \
        mate-applet-brisk-menu \
        mate-applets \
        mate-applets-common \
        mate-calc \
        mate-calc-common \
        mate-dock-applet \
        mate-hud \
        mate-indicator-applet \
        mate-indicator-applet-common \
        mate-menu \
        mate-notification-daemon \
        mate-notification-daemon-common \
        mate-utils \
        mate-utils-common \
        mate-window-applets-common \
        mate-window-buttons-applet \
        mate-window-menu-applet \
        mate-window-title-applet \
        ubuntu-mate-icon-themes \
        ubuntu-mate-themes \
        xrdp \
        xorgxrdp \
        tightvncserver && \
    apt-get install --no-install-recommends -yqq \
        supervisor \
        sudo \
        tzdata \
        vim \
        mc \
        ca-certificates \
        xterm \
        curl \
        wget \
        epiphany-browser && \
    ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -yqq chromium-browser gcc make ruby ruby-dev rubygems zlibc zlib1g zlib1g-dev libxml2 libxml2-dev gedit git npm firefox && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/*  && \
    echo "mate-session" > /etc/skel/.xsession && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini  && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini  && \
    xrdp-keygen xrdp auto  && \
    mkdir -p /var/run/xrdp && \
    chmod 2775 /var/run/xrdp  && \
    mkdir -p /var/run/xrdp/sockdir && \
    chmod 3777 /var/run/xrdp/sockdir && \
    echo "[program:sshd]" >/etc/supervisor/conf.d/sshd.conf && \
    echo "command=/usr/sbin/sshd -D" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "stdout_logfile=/var/log/supervisor/%(program_name)s.log" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "stderr_logfile=/var/log/supervisor/%(program_name)s.log" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "autorestart=true" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "[program:xrdp-sesman]" > /etc/supervisor/conf.d/xrdp.conf && \
    echo "command=/usr/sbin/xrdp-sesman --nodaemon" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "process_name = xrdp-sesman" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "[program:xrdp]" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "command=/usr/sbin/xrdp -nodaemon" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "process_name = xrdp" >> /etc/supervisor/conf.d/xrdp.conf
    
RUN wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | apt-key add - && \
    echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y vscodium
    
ADD xrdp.ini /etc/xrdp/xrdp.ini

ADD startup.sh  /root/startup.sh

RUN gem install bddfire 

ADD gherkin.lang /usr/share/gtksourceview-3.0/language-specs/gherkin.lang

RUN useradd -ms /bin/bash ubuntu && \
    echo "ubuntu:ubuntu" | chpasswd && \
    usermod -aG sudo ubuntu

RUN su - ubuntu -c "npm config set prefix '~/.npm-global'" && \
    su - ubuntu -c "echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc" && \
    su - ubuntu -c "npm install -g phantomjs-prebuilt geckodriver"

RUN git clone https://github.com/red-panda-ci/ci-scripts /opt/duingdemo/ci-scripts/common && \
    cd /opt/duingdemo && \
    bash ci-scripts/common/bin/_install.sh cucumber && \
    cd ci-scripts/test/cucumber && \
    bundle install && \
    sed "s/ddefault_max_wait_time/default_max_wait_time/g" -i features/support/env.rb && \
    cp config.yml.dist config.yml && \
    chown -R ubuntu:ubuntu /opt/duingdemo

RUN apt-get update && \
    apt-get install -y privoxy

RUN sed -i "s#listen-address  \[::1\]:8118##g" /etc/privoxy/config && \
    echo "debug 1" >> /etc/privoxy/config && \
    echo "[program:privoxy]" > /etc/supervisor/conf.d/privoxy.conf && \
    echo "command=/usr/sbin/privoxy --no-daemon /etc/privoxy/config" >> /etc/supervisor/conf.d/privoxy.conf && \
    echo "process_name = privoxy" >> /etc/supervisor/conf.d/privoxy.conf && \
    echo "stdout_logfile = /var/log/privoxy/privoxy.log" >> /etc/supervisor/conf.d/privoxy.conf && \
    echo "stderr_logfile = /var/log/privoxy/privoxy.err" >> /etc/supervisor/conf.d/privoxy.conf

ADD firefox/syspref.js       /etc/firefox/syspref.js

ADD chromium-browser/default /etc/chromium-browser/default

CMD ["/bin/bash", "/root/startup.sh"]
                                    
EXPOSE 3389
