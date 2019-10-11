
##################################################
## "build" stage
##################################################

FROM docker.io/ubuntu:18.04 AS build

# Install system packages
RUN export DEBIAN_FRONTEND=noninteractive \
	# Remove Canonical's "partner" repository
	&& sed -i '/archive\.canonical\.com/d;' /etc/apt/sources.list \
	# Uncomment source packages repositories
	&& sed -i 's/^#\s*\(deb-src\s\)/\1/g' /etc/apt/sources.list \
	# Enable multiarch support
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
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
## "xubuntu" stage
##################################################

FROM docker.io/ubuntu:18.04 AS xubuntu

# Install system packages
RUN export DEBIAN_FRONTEND=noninteractive \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		apt-transport-https \
		apt-utils \
		at-spi2-core \
		bash \
		bash-completion \
		binutils \
		ca-certificates \
		curl \
		dbus \
		dbus-x11 \
		desktop-file-utils \
		dialog \
		exo-utils \
		file \
		fonts-dejavu \
		fonts-liberation \
		fonts-noto \
		fonts-noto-color-emoji \
		fuse \
		git \
		gnupg \
		htop \
		iproute2 \
		iputils-ping \
		less \
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
		mime-support \
		nano \
		net-tools \
		netcat-openbsd \
		openssh-server \
		openssl \
		p7zip-full \
		pciutils \
		policykit-1 \
		procps \
		psmisc \
		pulseaudio \
		pulseaudio-utils \
		runit \
		sudo \
		systemd \
		tzdata \
		unzip \
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
		zip \
	&& apt-get install -y --no-install-recommends \
		libgl1-mesa-dri:i386 \
		libgl1-mesa-glx:i386 \
		libglu1-mesa:i386 \
		libxtst6:i386 \
		libxv1:i386 \
	&& apt-get install -y --no-install-recommends \
		adwaita-qt \
		atril \
		engrampa \
		ffmpegthumbnailer \
		firefox \
		gnome-keyring \
		gstreamer1.0-plugins-base \
		gstreamer1.0-plugins-good \
		gstreamer1.0-plugins-ugly \
		gtk2-engines-pixbuf \
		gtk2-engines-xfce \
		gtk3-engines-xfce \
		indicator-application \
		indicator-datetime \
		indicator-keyboard \
		indicator-messages \
		indicator-session \
		indicator-sound \
		libavcodec-extra \
		libcanberra-gtk-module \
		libcanberra-gtk3-module \
		libgtk-3-bin \
		menulibre \
		mousepad \
		mugshot \
		openjdk-8-jre \
		pavucontrol \
		ristretto \
		thunar-archive-plugin \
		thunar-volman \
		tumbler \
		vlc \
		xfce4 \
		xfce4-indicator-plugin \
		xfce4-notifyd \
		xfce4-power-manager-plugins \
		xfce4-pulseaudio-plugin \
		xfce4-statusnotifier-plugin \
		xfce4-taskmanager \
		xfce4-terminal \
		xfce4-whiskermenu-plugin \
		xfce4-xkb-plugin \
		xfpanel-switch \
		xubuntu-default-settings \
	&& rm -rf \
		/tmp/* /var/tmp/* \
		/var/lib/apt/lists/* \
		/etc/ssh/ssh_host_*

# Copy Tini build
COPY --from=docker.io/hectormolinero/tini:latest --chown=root:root /usr/bin/tini /usr/bin/tini

# Install libjpeg-turbo from package
COPY --from=build --chown=root:root /tmp/libjpeg-turbo/build/libjpeg-turbo_*.deb /tmp/libjpeg-turbo.deb
RUN dpkg -i --force-architecture /tmp/libjpeg-turbo.deb && rm -f /tmp/libjpeg-turbo.deb
COPY --from=build --chown=root:root /tmp/libjpeg-turbo/build32/libjpeg-turbo32_*.deb /tmp/libjpeg-turbo32.deb
RUN dpkg -i --force-architecture /tmp/libjpeg-turbo32.deb && rm -f /tmp/libjpeg-turbo32.deb

# Install VirtualGL from package
COPY --from=build --chown=root:root /tmp/virtualgl/build/virtualgl_*.deb /tmp/virtualgl.deb
RUN dpkg -i --force-architecture /tmp/virtualgl.deb && rm -f /tmp/virtualgl.deb
COPY --from=build --chown=root:root /tmp/virtualgl/build32/virtualgl32_*.deb /tmp/virtualgl32.deb
RUN dpkg -i --force-architecture /tmp/virtualgl32.deb && rm -f /tmp/virtualgl32.deb

## Install TurboVNC from package
#COPY --from=build --chown=root:root /tmp/turbovnc/build/turbovnc_*.deb /tmp/turbovnc.deb
#RUN dpkg -i --force-architecture /tmp/turbovnc.deb && rm -f /tmp/turbovnc.deb

# Install XRDP from package
COPY --from=build --chown=root:root /tmp/xrdp/xrdp_*.deb /tmp/xrdp.deb
RUN dpkg -i /tmp/xrdp.deb && rm -f /tmp/xrdp.deb

# Install xorgxrdp from package
COPY --from=build --chown=root:root /tmp/xorgxrdp/xorgxrdp_*.deb /tmp/xorgxrdp.deb
RUN dpkg -i /tmp/xorgxrdp.deb && rm -f /tmp/xorgxrdp.deb

# Install XRDP PulseAudio module from package
COPY --from=build --chown=root:root /tmp/xrdp-pulseaudio/xrdp-pulseaudio_*.deb /tmp/xrdp-pulseaudio.deb
RUN dpkg -i /tmp/xrdp-pulseaudio.deb && rm -f /tmp/xrdp-pulseaudio.deb

# Environment
ENV UNPRIVILEGED_USER_UID=1000
ENV UNPRIVILEGED_USER_GID=1000
ENV UNPRIVILEGED_USER_NAME=guest
ENV UNPRIVILEGED_USER_PASSWORD=password
ENV UNPRIVILEGED_USER_GROUPS=audio,input,video
ENV UNPRIVILEGED_USER_SHELL=/bin/bash
ENV DISABLE_GPU=false
ENV RDP_TLS_KEY_PATH=/etc/xrdp/key.pem
ENV RDP_TLS_CERT_PATH=/etc/xrdp/cert.pem
ENV PATH=/opt/VirtualGL/bin:${PATH}
#ENV PATH=/opt/TurboVNC/bin:${PATH}
ENV VGL_DISPLAY=:0
## Workaround for AMDGPU X_GLXCreatePbuffer issue:
## https://github.com/VirtualGL/virtualgl/issues/85#issuecomment-480291529
ENV VGL_FORCEALPHA=1
## Use Adwaita theme in QT applications
ENV QT_STYLE_OVERRIDE=Adwaita

# Setup locale
RUN printf '%s\n' 'en_US.UTF-8 UTF-8' > /etc/locale.gen
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8 ||:
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Setup timezone
ENV TZ=UTC
RUN ln -snf "/usr/share/zoneinfo/${TZ:?}" /etc/localtime
RUN printf '%s\n' "${TZ:?}" > /etc/timezone

# Setup D-Bus
RUN mkdir /run/dbus/ && chown messagebus:messagebus /run/dbus/
RUN dbus-uuidgen > /etc/machine-id && ln -sf /var/lib/dbus/machine-id /etc/machine-id

# Forward logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/xdummy.log
RUN ln -sf /dev/stdout /var/log/xrdp.log
RUN ln -sf /dev/stdout /var/log/xrdp-sesman.log

# Create /etc/skel/.xsession file
RUN printf '%s\n' 'exec xfce4-session' > /etc/skel/.xsession

# Create /etc/skel/.xsessionrc file
RUN printf '%s\n' \
		'export XDG_CACHE_HOME=${HOME:?}/.cache' \
		'export XDG_CONFIG_DIRS=/etc/xdg/xdg-xubuntu:/etc/xdg' \
		'export XDG_CONFIG_HOME=${HOME:?}/.config' \
		'export XDG_CURRENT_DESKTOP=XFCE' \
		'export XDG_DATA_DIRS=/usr/share/xubuntu:/usr/share/xfce4:/usr/local/share:/usr/share' \
		'export XDG_DATA_HOME=${HOME:?}/.local/share' \
		'export XDG_MENU_PREFIX=xfce-' \
		'export XDG_RUNTIME_DIR=/run/user/$(id -u)' \
		'export XDG_SESSION_DESKTOP=xubuntu' \
		> /etc/skel/.xsessionrc

# Create /etc/skel/.Xauthority file
RUN touch /etc/skel/.Xauthority

# Create /run/sshd directory
RUN mkdir /run/sshd/

# Create socket directory for X server
RUN mkdir /tmp/.X11-unix/ \
	&& chmod 1777 /tmp/.X11-unix/ \
	&& chown root:root /tmp/.X11-unix/

# Configure server for use with VirtualGL
RUN vglserver_config -config +s +f -t

# Copy config
COPY --chown=root:root config/ssh/sshd_config /etc/ssh/sshd_config
COPY --chown=root:root config/xrdp/xrdp.ini /etc/xrdp/xrdp.ini
COPY --chown=root:root config/xrdp/sesman.ini /etc/xrdp/sesman.ini

# Copy services
COPY --chown=root:root scripts/service/ /etc/sv/
RUN find /etc/sv/ -type d -mindepth 1 -maxdepth 1 -exec ln -sv '{}' /etc/service/ ';'

# Copy scripts
COPY --chown=root:root scripts/bin/ /usr/local/bin/

# Expose SSH port
EXPOSE 3322/tcp
# Expose RDP port
EXPOSE 3389/tcp

WORKDIR /
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/usr/local/bin/container-foreground-cmd"]
