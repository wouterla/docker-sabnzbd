FROM ubuntu:precise
MAINTAINER Tim Haak <tim@haak.co.uk>

RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe multiverse" >> /etc/apt/sources.list

RUN apt-get -q update

RUN apt-get install -qy --force-yes sabnzbdplus sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush par2 python-yenc unrar unzip 

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 8080 9090

ENTRYPOINT ["/start.sh"]
