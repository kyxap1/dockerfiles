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
apt-get update
apt-get install -qy wget findutils git-core sendmail-base bash-completion sendmail-bin

# sendmail setup
sed 's/Port=smtp, Addr=127.0.0.1/Port=smtp, Addr=0.0.0.0/' -i /etc/mail/sendmail.mc
sed 's/^MAILER.*//g' -i /etc/mail/sendmail.mc

cat >> /etc/mail/sendmail.mc << 'EOF'
define(`confCW_FILE', `-o /etc/mail/local-host-names')
FEATURE(virtusertable, `hash -o /etc/mail/virtusertable')
FEATURE(accept_unresolvable_domains)
MAILER(`local')dnl
MAILER(`smtp')dnl
EOF

cat >> /etc/mail/local-host-names << EOF
mx.kyxap.pro
kyxap.pro
EOF

cat >> /etc/mail/aliases << 'EOF'
kyxap: kyxap@pro-manage.net
EOF

mkdir -p /etc/service/sendmail
cat >> /etc/service/sendmail/run << 'EOF'
#!/usr/bin/env bash
/usr/sbin/sendmail -bd -v -q 15m

EOF

chmod +x /etc/service/sendmail/run

newaliases
make -C /etc/mail


# install dotfiles
git clone https://github.com/kyxap1/dotfiles /root/dist/dotfiles
bash -x /root/dist/dotfiles/copy.sh root

# add ssh key
wget -q -c http://pro-manage.net/kyxap.pub -O - > /root/.ssh/authorized_keys

