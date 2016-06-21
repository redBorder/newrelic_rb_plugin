# New Relic Redborder agent developers guide
---

This is a agent for the Redborder platform through New Relic Custom Plugin environment.

Monitoring:
  - Common resources (CPU, Memory, Packets received, Disk metrics, services by      memory)
  - Druid (Every metrics)
  - Nginx (Status code received)
  - Chef (Configuration errors)
  - Health checks for: Kafka, Zookeeper, Druid, Hadoop, Memcached, Nprobe, PostgreSQL, Riak and many more.

### Reporting Metrics
---
Every metrics is reported inside poll_cycle. This is a loop which can't take more than one minute reporting or
obtaining metrics.

Using the following line you will report the  metric with the name 'METRIC_NAME' and host concatenated and its VALUE.
```ruby
report_metric 'METRIC_NAME' + host,'Value', VALUE
```

### Obtaining Metrics
---
The whole agent has been developed under a dynamic philosophy in order to adapt it to agent behaviour.
That means that you'll report from services if they are running. Let's have a look over Druid example:

Druid metrics are reported from an array of hashes (`$metrics = []`). You can have many threads pushing data over it.
Each data is like a `tail -f`process that runs independently with each Druid log. That lets the poll_cycle not to waste time obtaining metrics.

The main function that has the ability to manage those threads is `druid_master` inside `/src/druid-master.rb`. This function uses `log_handler_druid` function located at `src/tail_f_druid.rb` with the aim of process each new line added to the proper log file. The line processing occurs inside `druid_parser` function located at `src/tail_f_druid.rb`. This function obtain the metric a push it to the following algorithm:
![alt tag](https://s32.postimg.org/qzqvgk31h/druid_diagrama.png)


You can add new metrics with different obtaining technologies but always being careful of poll_cycle time consumption.
It is recommended to follow the threadable method for this.

### Viewing data
---
Data reported to New Relic platform will be automatically accessible from the Redborder plugin dashboards. You can add new charts or tables clicking on Edit dashboard button. You can also add more than one metrics to the same chart groping with the star key (\*). Example:

Metrics with name "example_metric_a" and "example_metric_b" can be grouped with "example_metric_*" or "example_*".
