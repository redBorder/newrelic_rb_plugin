#!/bin/sh

mkdir config 2> /dev/null

echo "# Please make sure to update the license_key information with the license key for your New Relic
# account.
#
#
newrelic:
  #
  # Update with your New Relic account license key:
  #
  license_key: '$1'
  #
  # Set to '1' for verbose output, remove for normal output.
  # All output goes to stdout/stderr.
  #
  # verbose: 1

  # Proxy configuration:
  #proxy:
  #  address: localhost
  #  port: 8080
  #  user: nil
  #  password: nil

#
# Agent Configuration:
#
agents:
  # this is where configuration for agents belongs
  redborder:
    snmp_host: \"127.0.0.1\"
    snmp_community: \"redBorder\"
    services:
      - chef-client
      - druid_coordinator
      - druid_historical
      - druid_broker
      - druid_overlord
      - kafka
      - zookeeper
      - rb-webui
      - rb-workers
      - erchef
      - chef-solr
      - chef-expander
      - rabbitmq
      - postgresql
      - nginx
      - riak-cs
      - riak
      - hadoop_resourcemanager
      - rb-monitor
      - nprobe
      - memcached
      - rb-sociald
      - rb-discover
      - rb-snmp
      " > config/newrelic_plugin.yml

if [[ $? ]]; then
  bundle install
  cp rb_nr_agent /etc/rc.d/init.d/
fi
