require 'file-tail'

def druid_parser(line, file)

  unless line.nil?
    unless line.match(/"service":"(.*)","host/).nil? || line.match(/"metric":"(.*)","value/).nil? || line.match(/"value":(\d+),"/).nil?
      service = line.match(/"service":"(.*)","host/)[1]
      if service == 'middleManager'
        unless line.match(/"taskId":\["(.*)"\]}\]/).nil?
          service = line.match(/"taskId":\["(.*)"\]}\]/)[1]
        end
      # TODO: Change service middlemanager -> taskID
      # source: /tmp/druid-indexing/persistent/tasks/index_*/log
      end
      metric = (line.match(/"metric":"(.*)","value/)[1]).tr('/', '_')
      # puts metric
      value = line.match(/"value":(\d+),"/)[1]
    end
    #  unless service.nil? || value.nil?
    #  puts file + "Service is #{service},
    #  Metric is #{metric} and its value is #{value}"
    #  puts metric + ' is added with value: ' + value
    #  end

      unless service.nil? || value.nil?
        found = false
        $metrics.each do |m|
          if m["metric"] == metric && m["service"] == service
            found = true
            m["value"] = value
            m["ttl"] = 3
            m["iteration"] = $i
          end
        end
        if !found
          $metrics << {
            "metric" => metric,
            "service" => service,
            "value" => value,
            "ttl" => 3,
            "iteration" => $i
          }
        end
      end
    end
  end

  def log_handler(filename)
    File.open(filename, 'r') do |log|
      log.extend(File::Tail)
      log.backward(1)
      log.tail { |line| druid_parser(line, filename) }
    end
  end
