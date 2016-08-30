FROM alpine:latest
MAINTAINER Hywel Rees <hjr555@gmail.com>
ARG GITTAG=1.1.0RC4

RUN buildDeps="gcc g++ git mercurial make automake autoconf python-dev openssl-dev libffi-dev musl-dev" \
  && apk --update add $buildDeps \
  && apk add \
    python \
    py-pip \
    ffmpeg-libs \
    ffmpeg \
    unrar \
    openssl \
    ca-certificates \
    p7zip \
&& pip install --upgrade pip --no-cache-dir \
&& pip install pyopenssl cheetah --no-cache-dir \
&& git clone --depth 1 https://github.com/Parchive/par2cmdline.git \
&& cd /par2cmdline \
&& aclocal \
&& automake --add-missing \
&& autoconf \
&& ./configure \
&& make \
&& make install \
&& cd / \
&& rm -rf par2cmdline \
&& git clone --depth 1 --branch ${GITTAG} https://github.com/sabnzbd/sabnzbd.git \
&& hg clone https://bitbucket.org/dual75/yenc \
&& cd /yenc \
&& python setup.py build \
&& python setup.py install \
&& cd / \
&& rm -rf /yenc \
&& apk del $buildDeps \
&& rm -rf \
    /var/cache/apk/* \
    /par2cmdline \
    /yenc \
    /sabnzbd/.git \
    /tmp/*

EXPOSE 8080 9090

VOLUME ["/config", "/data"]

WORKDIR /sabnzbd

CMD su -pc "./SABnzbd.py -b 0 -f /config/ -s 0.0.0.0:8080"
