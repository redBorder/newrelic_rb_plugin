require 'file-tail'

def druid_parser(line, file)
  unless line.nil?
    unless line.match(/"metric":"(.*)","value/).nil?
      service = line.match(/"service":"(.*)","host/)[1]
    end
    unless line.match(/"metric":"(.*)","value/).nil?
      metric = line.match(/"metric":"(.*)","value/)[1]
    end
    unless line.match(/"value":(\d+),"/).nil?
      value = line.match(/"value":(\d+),"/)[1]
    end
    #  unless service.nil? || value.nil?
    #    puts file + "Service is #{service},
    #     Metric is #{metric} and its value is #{value}"
    #  end
    unless service.nil? || value.nil?
      $metrics.each do |m|
        if m["metric"] == metric && m["service"] == service
          m["value"] = value
          m["ttl"] = 3
          m["iteration"] = $i
        else
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
      #    puts 'metric added'
    end
  end

  def log_handler(filename)
    File.open(filename, 'r') do |log|
      log.extend(File::Tail)
      log.backward(1)
      #  puts 'here' + $i.to_s
      log.tail { |line| druid_parser(line, filename) }
    end
  end
