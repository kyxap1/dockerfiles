#docker run --hostname="irc.pro-manage.net" --name="irc.pro-manage.net" --publish="0.0.0.0::6661" --workdir="/root" -t -i  2085a446fea6 "/bin/bash"
# ./mkimage-debootstrap.sh pro-manage.net/debian wheezy http://mirrors.linode.com/debian/

# Debian Wheezy
#
# VERSION               0.0.1

FROM pro-manage.net/debian:latest
MAINTAINER Alexander Kyxap <kyxap@pro-manage.net>
ADD dist/debian.source.list /etc/apt/source.list
ADD dist/debian.supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD http://kyxap.org.ua/rc/screenrc /root/.screenrc
ADD http://kyxap.org.ua/rc/vimrc /root/.vimrc
RUN apt-get update
RUN apt-get install -y screen vim-nox supervisor apt-utils dialog wget
#RUN ["/usr/bin/wget", "-O /root/.screenrc", "http://kyxap.org.ua/rc/screenrc"]
#RUN ["/usr/bin/wget", "-O /root/.vimrc", "http://kyxap.org.ua/rc/vimrc"]
EXPOSE 6661
WORKDIR /root
CMD ["/usr/bin/supervisord"]


