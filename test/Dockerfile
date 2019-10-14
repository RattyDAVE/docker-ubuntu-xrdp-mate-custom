
##################################################
## "build" stage
##################################################

FROM ubuntu:18.04 AS build

# Install system packages
RUN export DEBIAN_FRONTEND=noninteractive \
	# Remove Canonical's "partner" repository
	&& sed -i '/archive\.canonical\.com/d;' /etc/apt/sources.list \
	# Uncomment source packages repositories
	&& sed -i 's/^#\s*\(deb-src\s\)/\1/g' /etc/apt/sources.list \
	# Enable multiarch support
	&& dpkg --add-architecture i386 \
	&& apt-get update -qq \
	&& apt-get install -y -qq --no-install-recommends \
		autoconf \
		automake \
		bash \
		bash-completion \
		bison \
		build-essential \
		ca-certificates \
		checkinstall \
		cmake \
		flex \
		git \
		intltool \
		libfdk-aac-dev \
		libfuse-dev \
		libgl1-mesa-dev \
		libglu1-mesa-dev \
		libmp3lame-dev \
		libopus-dev \
		libpam0g-dev \
		libpixman-1-dev \
		libpulse-dev \
		libssl-dev \
		libsystemd-dev \
		libtool \
		libx11-dev \
		libxext-dev \
		libxfixes-dev \
		libxml2-dev \
		libxrandr-dev \
		libxtst-dev \
		libxv-dev \
		nasm \
		pkg-config \
		python \
		python-libxml2 \
		texinfo \
		xserver-xorg-dev-hwe-18.04 \
		xsltproc \
		xutils-dev \
		g++-multilib \
		libgl1-mesa-dev:i386 \
		libglu1-mesa-dev:i386 \
		libxtst-dev:i386 \
		libxv-dev:i386 \
	&& rm -rf /var/lib/apt/lists/*

# Build libjpeg-turbo
ARG LIBJPEG_TURBO_TREEISH=2.0.3
ARG LIBJPEG_TURBO_REMOTE=https://github.com/libjpeg-turbo/libjpeg-turbo.git
WORKDIR /tmp/libjpeg-turbo/
RUN git clone "${LIBJPEG_TURBO_REMOTE:?}" ./
RUN git checkout "${LIBJPEG_TURBO_TREEISH:?}"
RUN git submodule update --init --recursive
WORKDIR ./build/
RUN cmake ./ \
		-G 'Unix Makefiles' \
		-D PKGNAME=libjpeg-turbo \
		-D CMAKE_BUILD_TYPE=Release \
		-D CMAKE_INSTALL_PREFIX=/opt/libjpeg-turbo \
		-D CMAKE_POSITION_INDEPENDENT_CODE=1 \
		../
RUN make -j"$(nproc)" && make deb
RUN dpkg -i --force-architecture ./libjpeg-turbo_*.deb
WORKDIR ../build32/
RUN CFLAGS='-m32' CXXFLAGS='-m32' LDFLAGS='-m32' \
	cmake ./ \
		-G 'Unix Makefiles' \
		-D PKGNAME=libjpeg-turbo \
		-D CMAKE_BUILD_TYPE=Release \
		-D CMAKE_INSTALL_PREFIX=/opt/libjpeg-turbo \
		-D CMAKE_POSITION_INDEPENDENT_CODE=1 \
		../
RUN make -j"$(nproc)" && make deb
RUN dpkg -i --force-architecture ./libjpeg-turbo32_*.deb

# Build VirtualGL
ARG VIRTUALGL_TREEISH=2.6.2
ARG VIRTUALGL_REMOTE=https://github.com/VirtualGL/virtualgl.git
WORKDIR /tmp/virtualgl/
RUN git clone "${VIRTUALGL_REMOTE:?}" ./
RUN git checkout "${VIRTUALGL_TREEISH:?}"
RUN git submodule update --init --recursive
WORKDIR ./build/
RUN cmake ./ \
		-G 'Unix Makefiles' \
		-D PKGNAME=virtualgl \
		-D CMAKE_BUILD_TYPE=Release \
		-D CMAKE_INSTALL_PREFIX=/opt/VirtualGL \
		-D CMAKE_POSITION_INDEPENDENT_CODE=1 \
		../
RUN make -j"$(nproc)" && make deb
RUN dpkg -i --force-architecture ./virtualgl_*.deb
WORKDIR ../build32/
RUN CFLAGS='-m32' CXXFLAGS='-m32' LDFLAGS='-m32' \
	cmake ./ \
		-G 'Unix Makefiles' \
		-D PKGNAME=virtualgl \
		-D CMAKE_BUILD_TYPE=Release \
		-D CMAKE_INSTALL_PREFIX=/opt/VirtualGL \
		-D CMAKE_POSITION_INDEPENDENT_CODE=1 \
		../
RUN make -j"$(nproc)" && make deb
RUN dpkg -i --force-architecture ./virtualgl32_*.deb

# Build TurboVNC
#ARG TURBOVNC_TREEISH=
#ARG TURBOVNC_REMOTE=https://github.com/TurboVNC/turbovnc.git
#WORKDIR /tmp/turbovnc/
#RUN git clone "${TURBOVNC_REMOTE:?}" ./
#RUN git checkout "${TURBOVNC_TREEISH:?}"
#RUN git submodule update --init --recursive
#WORKDIR ./build/
#RUN cmake ./ \
#		-G 'Unix Makefiles' \
#		-D PKGNAME=turbovnc \
#		-D CMAKE_BUILD_TYPE=Release \
#		-D CMAKE_INSTALL_PREFIX=/opt/TurboVNC \
#		-D CMAKE_POSITION_INDEPENDENT_CODE=1 \
#		-D TVNC_BUILDJAVA=0 \
#		../
#RUN make -j"$(nproc)" && make deb
#RUN dpkg -i --force-architecture ./turbovnc_*.deb

# Build XRDP
ARG XRDP_TREEISH=v0.9.11
ARG XRDP_REMOTE=https://github.com/neutrinolabs/xrdp.git
WORKDIR /tmp/xrdp/
RUN git clone "${XRDP_REMOTE:?}" ./
RUN git checkout "${XRDP_TREEISH:?}"
RUN git submodule update --init --recursive
RUN ./bootstrap
RUN ./configure \
		--prefix=/usr \
		--enable-vsock \
		--enable-tjpeg \
		--enable-fuse \
		--enable-fdkaac \
		--enable-opus \
		--enable-mp3lame \
		--enable-pixman
RUN make -j"$(nproc)"
RUN checkinstall --default --pkgname=xrdp --pkgversion=0 --pkgrelease=0

# Build xorgxrdp
ARG XORGXRDP_TREEISH=v0.2.11
ARG XORGXRDP_REMOTE=https://github.com/neutrinolabs/xorgxrdp.git
WORKDIR /tmp/xorgxrdp/
RUN git clone "${XORGXRDP_REMOTE:?}" ./
RUN git checkout "${XORGXRDP_TREEISH:?}"
RUN git submodule update --init --recursive
RUN ./bootstrap
RUN ./configure
RUN make -j"$(nproc)"
RUN checkinstall --default --pkgname=xorgxrdp --pkgversion=0 --pkgrelease=0

# Build XRDP PulseAudio module
ARG XRDP_PULSEAUDIO_TREEISH=v0.3
ARG XRDP_PULSEAUDIO_REMOTE=https://github.com/neutrinolabs/pulseaudio-module-xrdp.git
WORKDIR /tmp/
RUN apt-get update
RUN apt-get build-dep -y pulseaudio
RUN apt-get source pulseaudio && mv ./pulseaudio-*/ ./pulseaudio/
WORKDIR /tmp/pulseaudio/
RUN ./configure
WORKDIR /tmp/xrdp-pulseaudio/
RUN git clone "${XRDP_PULSEAUDIO_REMOTE:?}" ./
RUN git checkout "${XRDP_PULSEAUDIO_TREEISH:?}"
RUN git submodule update --init --recursive
RUN ./bootstrap
RUN ./configure PULSE_DIR=/tmp/pulseaudio/
RUN make -j"$(nproc)"
RUN checkinstall --default --pkgname=xrdp-pulseaudio --pkgversion=0 --pkgrelease=0

##################################################

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/opt/VirtualGL/bin:${PATH}
ENV VGL_DISPLAY=:0
ENV VGL_FORCEALPHA=1
ENV QT_STYLE_OVERRIDE=Adwaita

COPY --from=build --chown=root:root /tmp/libjpeg-turbo/build/libjpeg-turbo_*.deb /tmp/libjpeg-turbo.deb
COPY --from=build --chown=root:root /tmp/libjpeg-turbo/build32/libjpeg-turbo32_*.deb /tmp/libjpeg-turbo32.deb
COPY --from=build --chown=root:root /tmp/virtualgl/build/virtualgl_*.deb /tmp/virtualgl.deb
COPY --from=build --chown=root:root /tmp/virtualgl/build32/virtualgl32_*.deb /tmp/virtualgl32.deb
COPY --from=build --chown=root:root /tmp/xrdp/xrdp_*.deb /tmp/xrdp.deb
COPY --from=build --chown=root:root /tmp/xorgxrdp/xorgxrdp_*.deb /tmp/xorgxrdp.deb
COPY --from=build --chown=root:root /tmp/xrdp-pulseaudio/xrdp-pulseaudio_*.deb /tmp/xrdp-pulseaudio.deb

RUN dpkg --add-architecture i386 \
	&& apt-get update -qq \
	&& apt-get install -y --no-install-recommends \
		at-spi2-core \
		bash \
		bash-completion \
		binutils \
		ca-certificates \
		curl \
		dbus \
		dbus-x11 \
		dialog \
		exo-utils \
		file \
		fuse \
		gnupg \
		libexo-1-0 \
		libfdk-aac1 \
		libgl1-mesa-dri \
		libgl1-mesa-glx \
		libglu1-mesa \
		libmp3lame0 \
		libopus0 \
		libpam0g \
		libpixman-1-0 \
		libpulse0 \
		libssl1.1 \
		libsystemd0 \
		libx11-6 \
		libxext6 \
		libxfixes3 \
		libxml2 \
		libxrandr2 \
		libxtst6 \
		libxv1 \
		locales \
		lsscsi \
		menu \
		menu-xdg \
		mesa-utils \
		mesa-utils-extra \
		openssh-server \
		openssl \
		pciutils \
		policykit-1 \
		pulseaudio \
		pulseaudio-utils \
		runit \
		sudo \
		systemd \
		tzdata \
		usbutils \
		wget \
		xauth \
		xdg-user-dirs \
		xdg-utils \
		xfonts-base \
		xserver-xorg-core-hwe-18.04 \
		xserver-xorg-video-all-hwe-18.04 \
		xterm \
		xutils \
		xz-utils \
		zenity \
	&& apt-get install -y --no-install-recommends \
		libgl1-mesa-dri:i386 \
		libgl1-mesa-glx:i386 \
		libglu1-mesa:i386 \
		libxtst6:i386 \
		libxv1:i386 && \
    apt-get install -y --no-install-recommends \
	adwaita-qt && \
    apt-get install -y \
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
    dpkg -i --force-architecture /tmp/libjpeg-turbo.deb && rm -f /tmp/libjpeg-turbo.deb && \
    dpkg -i --force-architecture /tmp/libjpeg-turbo32.deb && rm -f /tmp/libjpeg-turbo32.deb && \
    dpkg -i --force-architecture /tmp/virtualgl.deb && rm -f /tmp/virtualgl.deb && \
    dpkg -i --force-architecture /tmp/virtualgl32.deb && rm -f /tmp/virtualgl32.deb && \
    dpkg -i /tmp/xrdp.deb && rm -f /tmp/xrdp.deb && \
    dpkg -i /tmp/xorgxrdp.deb && rm -f /tmp/xorgxrdp.deb && \
    dpkg -i /tmp/xrdp-pulseaudio.deb && rm -f /tmp/xrdp-pulseaudio.deb  && \
    printf '%s\n' 'en_GB.UTF-8 UTF-8' > /etc/locale.gen && \
    localedef -c -i en_GB -f UTF-8 en_GB.UTF-8 ||: && \
    ln -snf "/usr/share/zoneinfo/Europe/London" /etc/localtime  && \
    printf '%s\n' "Europe/London" > /etc/timezone  && \
    mkdir /run/dbus/ && chown messagebus:messagebus /run/dbus/  && \
    dbus-uuidgen > /etc/machine-id && ln -sf /var/lib/dbus/machine-id /etc/machine-id && \
    ln -sf /dev/stdout /var/log/xdummy.log  && \
    ln -sf /dev/stdout /var/log/xrdp.log && \
    ln -sf /dev/stdout /var/log/xrdp-sesman.log && \
    printf '%s\n' 'exec mate-session' > /etc/skel/.xsession && \
    printf '%s\n' \
		'export XDG_CACHE_HOME=${HOME:?}/.cache' \
		'export XDG_CONFIG_DIRS=/etc/xdg/xdg-xubuntu:/etc/xdg' \
		'export XDG_CONFIG_HOME=${HOME:?}/.config' \
		'export XDG_CURRENT_DESKTOP=XFCE' \
		'export XDG_DATA_DIRS=/usr/share/xubuntu:/usr/share/xfce4:/usr/local/share:/usr/share' \
		'export XDG_DATA_HOME=${HOME:?}/.local/share' \
		'export XDG_MENU_PREFIX=xfce-' \
		'export XDG_RUNTIME_DIR=/run/user/$(id -u)' \
		'export XDG_SESSION_DESKTOP=xubuntu' \
		> /etc/skel/.xsessionrc  && \
    touch /etc/skel/.Xauthority && \
    mkdir /run/sshd/  && \
    mkdir /tmp/.X11-unix/  && \
	chmod 1777 /tmp/.X11-unix/  && \
	chown root:root /tmp/.X11-unix/ && \
    vglserver_config -config +s +f -t && \
    echo "[program:sshd]" >/etc/supervisor/conf.d/sshd.conf && \
    echo "command=/usr/sbin/sshd -D" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "autorestart=true" >> /etc/supervisor/conf.d/sshd.conf && \
    echo "[program:dbus-daemon]" > /etc/supervisor/conf.d/dbus-daemon.conf && \
    echo "command=/usr/bin/dbus-daemon --system --nofork" >> /etc/supervisor/conf.d/dbus-daemon.conf && \
    echo "process_name = dbus-daemon" >> /etc/supervisor/conf.d/dbus-daemon.conf && \
    echo "user = messagebus" >> /etc/supervisor/conf.d/dbus-daemon.conf && \
    echo "[program:xdummy]" > /etc/supervisor/conf.d/xdummy.conf.new && \
    echo "command=/usr/bin/Xorg -noreset -nolisten tcp +extension GLX +extension RANDR +extension RENDER -logfile /var/log/xdummy.log :0" >> /etc/supervisor/conf.d/xdummy.conf.new && \
    echo "process_name = xdummy" >> /etc/supervisor/conf.d/xdummy.conf.new && \
    echo "[program:xrdp-sesman]" > /etc/supervisor/conf.d/xrdp.conf && \
    echo "command=/usr/sbin/xrdp-sesman --nodaemon" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "process_name = xrdp-sesman" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "[program:xrdp]" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "command=/usr/sbin/xrdp --nodaemon" >> /etc/supervisor/conf.d/xrdp.conf && \
    echo "process_name = xrdp" >> /etc/supervisor/conf.d/xrdp.conf && \
    rm -rf \
	/tmp/* /var/tmp/* \
	/var/lib/apt/lists/* \
	/etc/ssh/ssh_host_* && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g)

COPY --chown=root:root config/xrdp/xrdp.ini /etc/xrdp/xrdp.ini
COPY --chown=root:root config/xrdp/sesman.ini /etc/xrdp/sesman.ini

EXPOSE 22/tcp 3389/tcp

WORKDIR /

ADD autostartup.sh /root/autostartup.sh
CMD ["/bin/bash", "/root/autostartup.sh"]
