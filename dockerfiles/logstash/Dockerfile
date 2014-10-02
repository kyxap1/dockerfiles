# Name:        logstash
# Description: Install logstash 1.4.1
# OS:          Debian Wheezy
# Version:     0.0.1

FROM pro-manage.net/debian

MAINTAINER Alexander Kyxap <kyxap@pro-manage.net>

EXPOSE 22 514 9200 9292

ADD dist/ /root/dist

RUN cp /root/dist/elasticsearch.repo.list /etc/apt/sources.list.d/elasticsearch.list; \
wget -q -4 -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -; \
apt-get update; apt-get upgrade -qy; apt-get install -q -y logstash elasticsearch; \
cp /root/dist/logstash.supervisor.conf /etc/supervisor/conf.d/logstash.conf; \
cp /root/dist/logstash-agent.conf /etc/logstash/conf.d/logstash.conf; \
cd /opt; \
git clone https://github.com/elasticsearch/kibana.git /opt/kibana; \
rm -r /root/dist

# default start command
CMD ["/usr/bin/supervisord"]

