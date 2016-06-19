# Redborder Platform Plugin Agent for NewRelic
---
![alt text](http://www.aeiciberseguridad.es/imagenes%5Cdescargas%5C7492047.jpg "Redborder")
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
![alt text](https://www.drupal.org/files/styles/grid-3/public/NewRelic.png?itok=tmr3C7yP "NewRelic")

#### Version 1.0.1
---
This is a agent for the Redborder platform through NewRelic Custom Plugin environment.

You can monitor:
  - Common resources (CPU, Memory, Packets received, Disk metrics, services by      memory)
  - Druid (Every metrics)
  - Nginx (Status code received)
  - Chef (Configuration errors)
  - Health checks for: Kafka, Zookeeper, Druid, Hadoop, Memcached, Nprobe,            PostgreSQL, Riak and many more.

### Installation
---
The installation process consists on:

1. Create a free account in NewRelic
2. Copy your License Key (you can find it in your account settings)
3. Clone this repo:

```sh
$> git clone https://github.com/franrios/newrelic_rb_plugin.git
$> cd newrelic_rb_plugin
```
### Configuration
---
1. Configure the agent as follow:
```sh
$> ./configuration.sh LICENSE_KEY INSTANCE_IP
```
Wait a few minutes and you will see the angent automatically added to your plugin section in NewRelic platform

### Let's send data!
You can do this in two ways:
1. Using service script:
```sh
$> service rb_nr_agent start
```
Then it will be running in background

2. Directly with the main file
```sh
$> nohup ./newrelic_redborder_agent &
```
### Logging
By default loggin is enabled in INFO mode. Log file is located in the following path:
`/var/log/newrelic/plugin.log`

You can enable DEBUGG mode as follow:
```sh
$> nohup ./newrelic_redborder_agent --log debug &
```
