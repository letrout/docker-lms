FROM ubuntu:18.04
LABEL maintainer="Joel Luth (joel.luth@gmail.com)"
LABEL description="Logitech Media Server"

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
