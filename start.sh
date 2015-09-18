#!/bin/bash
#
# /usr/local/bin/start.sh
# Start Elasticsearch, Logstash and Kibana services
#
CONFIG_DIR=/elasticsearch/config
LUMBERJACK_DIR=/etc/logstash/conf.d

# Set the required login credentials so that this image can be used as an
# authenticated Cloud Foundry service container and component can access
# Elasticsearch while the http-basic plugin is in use.
echo "Running setup..."
if [[ -e /.firstrun ]]; then
  echo "Looks like a first run..."
  sed -i -e"s/ES_USER/$ES_USERNAME/" $CONFIG_DIR/elasticsearch.yml
  sed -i -e"s/ES_PASS/$ES_PASSWORD/" $CONFIG_DIR/elasticsearch.yml
  sed -i -e"s/ES_USER/$ES_USERNAME/" $LUMBERJACK_DIR/30-lumberjack-output.conf
  sed -i -e"s/ES_PASS/$ES_PASSWORD/" $LUMBERJACK_DIR/30-lumberjack-output.conf
  sed -i '' -e '$a\' /opt/kibana/config/kibana.yml
  echo "elasticsearch.username: $ES_USERNAME" >> /opt/kibana/config/kibana.yml
  echo "elasticsearch.password: $ES_PASSWORD" >> /opt/kibana/config/kibana.yml
  rm /.firstrun
fi

# Make sure our unprivileged user can access the Elasticsearch data.
echo "Preparing to drop root..."
chown -R elasticsearch:elasticsearch /data

# Drop root perms via gosu for security.
echo "Dropping root and starting Elasticsearch..."
gosu elasticsearch /elasticsearch/bin/elasticsearch -d

# Start logstash.
service logstash start

# wait for elasticsearch to start up - https://github.com/elasticsearch/kibana/issues/3077
counter=0
while [ ! "$(curl localhost:9200 2> /dev/null)" -a $counter -lt 30  ]; do
  sleep 1
  ((counter++))
  echo "waiting for Elasticsearch to be up ($counter/30)"
done
echo "Waiting a bit longer..."
sleep 3
service kibana start

tail -f /data/log/elasticsearch.log
