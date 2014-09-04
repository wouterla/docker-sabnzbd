FROM ubuntu:14.04
MAINTAINER Tim Haak <tim@haak.co.uk>

RUN locale-gen en_US en_US.UTF-8

RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe multiverse" >> /etc/apt/sources.list

RUN apt-get -q update
RUN apt-mark hold initscripts udev plymouth mountall
RUN apt-get -qy --force-yes dist-upgrade

RUN apt-get install -qy python-software-properties software-properties-common

RUN add-apt-repository -y  ppa:jcfp/ppa

RUN apt-get -q update

RUN apt-get install -qy --force-yes sabnzbdplus
RUN apt-get install -qy --force-yes sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush
RUN apt-get install -qy --force-yes par2 python-yenc unzip unrar

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

# apt clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 8080 9090

CMD ["/start.sh"]
