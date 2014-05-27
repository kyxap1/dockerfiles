# Name:        ubuntu
# Description: Contains debootstrap basic image optimization.
#              Install additional software.
#              Tuning base system.
# OS:          Ubuntu 14 LTS
# Version:     0.0.1
# Pre-req:     /opt/dockerbuilds/scripts/mkimage-debootstrap.sh -i 'iproute,iputils-ping,apt-utils' pro-manage.net/ubuntu-minimal trusty http://mirrors.linode.com/ubuntu/
# Usage:       docker run --hostname="DOMAIN.pro-manage.net" --name="DOMAIN.pro-manage.net" -d CONTAINER_ID

# choose basic image
FROM pro-manage.net/ubuntu-minimal

MAINTAINER Alexander Kyxap <kyxap@pro-manage.net>

EXPOSE 22 80

# copy dist directory
ADD dist/ /root/dist

RUN cp -b /root/dist/sources.list /etc/apt/sources.list; \
apt-get -q update; apt-get upgrade -q -y; apt-get install -q -y findutils; \
xargs apt-get install -q -y < /root/dist/software.list; \
mkdir -p /var/run/sshd; \
mkdir /root/.ssh; chmod 700 /root/.ssh; \
cp /root/dist/authorized_keys /root/.ssh/authorized_keys; \
cp /root/dist/supervisord.conf /etc/supervisor/conf.d/supervisord.conf; \
mkdir -p /var/log/supervisor; \
rm -rf /root/dist; \
sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd;

# bug in official ubuntu image

# app configs
# need to add git .dot files

ONBUILD RUN rm /etc/ssh/ssh_host_*; dpkg-reconfigure openssh-server

# default start command
CMD ["/usr/bin/supervisord"]


