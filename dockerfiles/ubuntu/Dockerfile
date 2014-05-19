# Pre-req:     /opt/dockerbuilds/scripts/mkimage-debootstrap.sh pro-manage.net/debian wheezy http://mirrors.linode.com/debian/
# Usage:       docker run --hostname="DOMAIN.pro-manage.net" --name="DOMAIN.pro-manage.net" -d CONTAINER_ID
# Usage:       docker build --tag="pro-manage.net/ubuntu:baklan" --rm=true .

# choose basic image
FROM dockerfile/ubuntu

MAINTAINER Alexander Kyxap <kyxap@pro-manage.net>

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD http://kyxap.org.ua/rc/screenrc /root/.screenrc
ADD http://kyxap.org.ua/rc/vimrc /root/.vimrc
RUN apt-get update
RUN apt-get install -y screen vim-nox supervisor apt-utils dialog wget 
WORKDIR /root
CMD ["/usr/bin/supervisord"]


