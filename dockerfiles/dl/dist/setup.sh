#!/usr/bin/env bash

# setup locale
cat >/etc/default/locale <<EOF
LANG="en_US.UTF-8"
LANGUAGE="en_US:en"
EOF

cp /root/dist/02apt-cacher-ng /etc/apt/apt.conf.d/02apt-cacher-ng

source /etc/default/locale

# install packages
apt-get update
apt-get upgrade -qy
apt-get install -qy wget findutils git-core bash-completion pwgen

# install dotfiles
git clone https://github.com/kyxap1/dotfiles /root/dist/dotfiles
bash /root/dist/dotfiles/copy.sh root

# add ssh key
wget -q -c http://pro-manage.net/kyxap.pub -O - > /root/.ssh/authorized_keys

# set uploads dir
UPLOADS=/home/uploads

#################### btsync installation
### admin interface: http://$btsync_hostname:$btsync_webport
###
### don't forget to set:
### "allow_empty_password": false
### "login": "actual login"
### "password": "actual password"
###

btsync_hostname=dl.kyxap.pro
btsync_listen=0.0.0.0
btsync_port=31333
btsync_webport=12089
btsync_user=btsync
btsync_home=/home/$btsync_user
shell=/usr/sbin/nologin

storage=$btsync_home/settings
shared=$UPLOADS/$btsync_user

install_prefix=/opt/btsync

btsync_binary=$install_prefix/bin/btsync-server
btsync_config=$install_prefix/conf/btsync.json

btsync_log=$install_prefix/logs/btsync.log
btsync_pid=$install_prefix/run/btsync.pid

dl_url="http://download-new.utorrent.com/endpoint/btsync/os/linux-x64/track/stable"

# create user for btsync
useradd -p `pwgen -s 14 1 | openssl passwd -stdin` -d $btsync_home -m -s $shell $btsync_user

# make dirs
mkdir -p `dirname $btsync_binary $btsync_config $btsync_log $btsync_pid` $storage $shared

# download/extract
wget -q --content-disposition -O - $dl_url | tar xz btsync -O > $btsync_binary

# setup predefined config
cat >$btsync_config << EOF
{
    "device_name": "$btsync_hostname",
    "download_limit": 0,
    "upload_limit": 0,
    "listening_port": $btsync_port,
    "pid_file": "$btsync_pid",
    "storage_path": "$storage",
    "use_upnp": false,
    "webui": {
        "allow_empty_password": true,
        "directory_root": "$shared",
        "force_https": false,
        "listen": "$btsync_listen:$btsync_webport"
//      "login": "admin",
//      "password": "$(pwgen 14 1)"
    }
}
EOF

# setup autostart with runit
mkdir -p /etc/service/`basename $btsync_binary`

cat >/etc/service/`basename $btsync_binary`/run << EOF
#!/bin/sh
/sbin/setuser $btsync_user $btsync_binary --nodaemon --log $btsync_log --config $btsync_config
EOF

chmod 770 /etc/service/`basename $btsync_binary`/run

# securing dirs/configs
chmod 700 $btsync_binary
chmod 600 $btsync_config

# generate dist config
$btsync_binary --dump-sample-config > ${btsync_config}.dist

# set owner
chown -R $btsync_user:$btsync_user $btsync_home $install_prefix $shared

######################## php + uploader
### https://github.com/ziggi/zimg-host
###

# installing php
apt-get install -qy php5-fpm

