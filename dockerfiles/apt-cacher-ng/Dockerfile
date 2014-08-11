# Name:        apt-cacher-ng
# Description: apt proxy
# OS:          Debian Wheezy
# Version:     0.0.1

# choose basic image
FROM pro-manage.net/debian

MAINTAINER Alexander Kyxap <kyxap@pro-manage.net>

EXPOSE 22 3142

ADD dist/02apt-cacher-ng /etc/apt/apt.conf.d/02apt-cacher-ng

# software
RUN apt-get -q update; \
apt-get upgrade -q -y; \
apt-get install -q -y apt-cacher-ng; \
mkdir -p /var/run/apt-cacher-ng; \
chown apt-cacher-ng:apt-cacher-ng /var/run/apt-cacher-ng

ADD dist/apt-cacher-ng.supervisor.conf /etc/supervisor/conf.d/apt-cacher-ng.conf

# default start command
CMD ["/usr/bin/supervisord"]


