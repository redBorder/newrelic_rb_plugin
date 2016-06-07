# Redborder Platform Plugin Agent for NewRelic
---
![alt text](http://www.aeiciberseguridad.es/imagenes%5Cdescargas%5C7492047.jpg "Redborder")
___
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
        $ git clone https://github.com/franrios/newrelic_rb_plugin.git
        $ cd newrelic_rb_plugin
      ```
4. Configure the agent as follow:
  ```sh
  $ ./configuration.sh LICENSE_KEY INSTANCE_IP
  $ nohup ./newrelic_redborder_agent &
  ```
