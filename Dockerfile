FROM ubuntu:18.04
LABEL maintainer="Joel Luth (joel.luth@gmail.com)"
LABEL description="Logitech Media Server"

ENV LANG C.UTF-8
ENV LMS_VOL /srv/lms
ENV LMS_UID 2001
ENV LMS_GID 2001
ENV LMS_VER 7.9.1
ENV LMS_ARCH amd64
ENV LMS_PKG logitechmediaserver_${LMS_VER}_${LMS_ARCH}.deb
ENV LMS_PKG_URL http://downloads-origin.slimdevices.com/LogitechMediaServer_v${LMS_VER}/${LMS_PKG}

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		curl \
		faad \
		flac \
		lame \
		libio-socket-ssl-perl \
		sox \
		xz-utils \
	&& apt-get clean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

RUN curl ${LMS_PKG_URL} -o ${LMS_PKG} \
	&& dpkg -i ${LMS_PKG} \
	&& rm -f ${LMS_PKG} \
	&& apt-get clean

RUN userdel squeezeboxserver \
	&& groupadd -g ${LMS_GID} squeezeboxserver \
	&& useradd -u ${LMS_UID} -g ${LMS_GID} \
		-d /usr/share/squeezeboxserver/ \
		-c 'Logitech Media Server' \
		squeezeboxserver

VOLUME ${LMS_VOL}
EXPOSE 3483 3483/udp 9000 9090

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
