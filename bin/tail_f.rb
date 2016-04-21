require 'file-tail'

def druid_parser(line, file)

  unless line.nil?
    unless line.match(/"service":"(.*)","host/).nil?
      service = line.match(/"service":"(.*)","host/)[1]
      puts service
    end
    unless line.match(/"metric":"(.*)","value/).nil?
      metric = (line.match(/"metric":"(.*)","value/)[1]).tr('/', '_')
      puts metric
    end
    unless line.match(/"value":(\d+),"/).nil?
      value = line.match(/"value":(\d+),"/)[1]
      puts value
    end
#=begin
      unless service.nil? || value.nil?
        puts file + "Service is #{service},
         Metric is #{metric} and its value is #{value}"
         puts metric + ' is added with value: ' + value

      #   report_metric  metric + '_' + service + '_' + `hostname`.strip, 'Value', value

      end
#=end
binding.pry
 puts $metrics.size.to_s
binding.pry
    unless service.nil? || value.nil?

      $metrics.each do |m|
        if m["metric"] == metric && m["service"] == service
          m["value"] = value
          m["ttl"] = 3
          m["iteration"] = $i
          puts m
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
      log.tail { |line| druid_parser(line, filename) }
    end
  end
