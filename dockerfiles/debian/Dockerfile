# Name:        debian
# Description: Contains debootstrap basic image optimization.
#              Install additional software.
#              Tuning base system.
# OS:          Debian Wheezy
# Version:     0.0.1
# Pre-req:     /opt/dockerbuilds/scripts/mkimage-debootstrap.sh pro-manage.net/debian wheezy http://mirrors.linode.com/debian/
# Usage:       docker run --hostname="DOMAIN.pro-manage.net" --name="DOMAIN.pro-manage.net" -d CONTAINER_ID

# choose basic image
FROM pro-manage.net/debian:latest

MAINTAINER Alexander Kyxap <kyxap@pro-manage.net>

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD http://kyxap.org.ua/rc/screenrc /root/.screenrc
ADD http://kyxap.org.ua/rc/vimrc /root/.vimrc

RUN apt-get update
RUN apt-get install -y openssh-server
RUN apt-get install -y moreutils apt-utils bash-completion bc bridge-utils busybox bzip2 coreutils curl dialog dnsutils dos2unix fakeroot findutils gzip hostname htop iotop iproute iptables iputils-ping less links locales lsof make mtr netcat patch perl procps psmisc pwgen rsync screen sed strace supervisor tar tcpdump telnet unzip vim-nox wget whois zip

RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

CMD ["/usr/bin/supervisord"]


