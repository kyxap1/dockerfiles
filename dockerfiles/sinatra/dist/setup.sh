#!/usr/bin/env bash

# setup locale
cat >/etc/default/locale <<EOF
LANG="en_US.UTF-8"
LANGUAGE="en_US:en"
EOF

cat /etc/resolv.conf

cp /root/dist/02apt-cacher-ng /etc/apt/apt.conf.d/02apt-cacher-ng

source /etc/default/locale

# install packages
apt-get update -q
apt-get upgrade -qy
apt-get install -qy wget findutils git-core

# install dotfiles
git clone https://github.com/kyxap1/dotfiles /root/dist/dotfiles
bash -x /root/dist/dotfiles/copy.sh root

# add ssh key
wget -q -c http://pro-manage.net/kyxap.pub -O - > /root/.ssh/authorized_keys

