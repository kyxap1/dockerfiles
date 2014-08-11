#!/usr/bin/env bash
DIST=/root/dist
WORKDIR=/opt/src

user=stream
home=/home/$user
shell=/bin/bash
docroot=$home/pub

NGINX_VER=1.7.1
NGINX_SRC=nginx-${NGINX_VER}.tar.gz

# create user for nginx docroot
useradd -p `pwgen -s 14 1 | openssl passwd -stdin` -d $home -m -s $shell $user

https://github.com/kyxap1/nginx-custom-module.git/

# get nginx-rtmp-module
git clone https://github.com/arut/nginx-rtmp-module.git /opt/src/nginx-rtmp-module
# build nginx
wget -t3 -qc http://nginx.org/download/$NGINX_SRC
tar xf $NGINX_SRC && cd nginx-*
./configure \
 --prefix=/var/www \
 --user=$user --group=$user \
 --sbin-path=/usr/sbin/nginx \
 --conf-path=/etc/nginx/nginx.conf \
 --pid-path=/var/run/nginx.pid \
 --error-log-path=/var/log/nginx/error.log \
 --http-log-path=/var/log/nginx/access.log \
 --with-http_ssl_module \
 --without-http_proxy_module \
 --with-http_flv_module \
 --with-http_mp4_module \
 --add-module=/opt/src/nginx-rtmp-module

make -j`grep ^processor /proc/cpuinfo | wc -l`
make install
# copy stat.xsl from rtmp module sources
cp $WORKDIR/nginx-rtmp-module/stat.xsl $docroot/html

##################### FFMPEG + WEBM + OGG ###################

apt-get -qy install libxml2-dev libxslt1-dev

# install ffmpeg
apt-get update -q
apt-get install -qy --force-yes deb-multimedia-keyring
apt-get update -q
apt-get install -qy -t jessie ffmpeg libav-tools

