# Name:        debian
# Description: Contains debootstrap basic image optimization.
#              Install additional software.
#              Tuning base system.
# OS:          Debian Wheezy
# Version:     0.0.1
# Pre-req:     /opt/dockerbuilds/scripts/mkimage-debootstrap.sh -i 'iproute,iputils-ping,apt-utils' pro-manage.net/debian-minimal wheezy http://mirrors.linode.com/debian/
# Usage:       docker run --hostname="DOMAIN.pro-manage.net" --name="DOMAIN.pro-manage.net" -d CONTAINER_ID

# choose basic image
FROM pro-manage.net/debian-minimal:wheezy

MAINTAINER Alexander Kyxap <kyxap@pro-manage.net>

EXPOSE 22

# copy dist directory
ADD dist/ /root/dist

# software
RUN cp /root/dist/02apt-cacher-ng /etc/apt/apt.conf.d/02apt-cacher-ng; \
cp -b /root/dist/sources.list /etc/apt/sources.list; \
cp -b /root/dist/sources.backports.list /etc/apt/sources.list.d/backports.list; \
cp /root/dist/locale.gen /etc/locale.gen; \
apt-get -q update; apt-get upgrade -q -y; apt-get install -q -y findutils; \
cat /root/dist/software.list | xargs apt-get install -q -y; \
mkdir -p /var/run/sshd; mkdir /root/.ssh; chmod 700 /root/.ssh; \
cp /root/dist/authorized_keys /root/.ssh/authorized_keys; \
cp /root/dist/supervisord.conf /etc/supervisor/conf.d/supervisord.conf; \
mkdir -p /var/log/supervisor; \
cp -b /root/dist/rsyslog.conf /etc/rsyslog.conf

RUN git clone https://github.com/kyxap1/dotfiles /root/dist/dotfiles; /root/dist/dotfiles/copy.sh; \
rm -rf /root/dist;

ONBUILD RUN rm /etc/ssh/ssh_host_*; dpkg-reconfigure openssh-server

# default start command
CMD ["/usr/bin/supervisord"]


