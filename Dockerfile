FROM riscv64/debian:unstable

MAINTAINER vimer
CMD ["echo", "This is test for build LO on riscv64 Docker image"]


WORKDIR /root/

# LO tarball and external module should be opt

# keep tarball wtih Dockerfile in a same dir if prepare tarball
# in docker image, otherwise comment out it
COPY libreoffice-7.3.4.2.tar.xz ./
ADD patch ./patch

RUN apt update -y && apt install ca-certificates -y

ENV SOURCES_LIST=/etc/apt/sources.list

RUN mv /etc/apt/sources.list /etc/apt/sources-bak.list \
        && echo "deb  http://mirror.iscas.ac.cn/debian-ports unstable main" >> $SOURCES_LIST

RUN apt update -y \
    && \
	DEBIAN_FRONTEND=noninteractive \
	apt install -y -qq --no-install-recommends \
    git build-essential zip ccache junit4 libkrb5-dev nasm graphviz python3 python3-dev wget\
    qtbase5-dev libkf5coreaddons-dev libkf5i18n-dev libkf5config-dev libkf5windowsystem-dev libkf5kio-dev autoconf \
    libcups2-dev libfontconfig1-dev gperf default-jdk doxygen libxslt1-dev xsltproc libxml2-utils libxrandr-dev libx11-dev \
    bison flex libgtk-3-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev ant ant-optional libnss3-dev libavahi-client-dev \
	&& rm -rf /var/lib/apt/lists/*

CMD ["echo", "update done"]
