require 'file-tail'

def druid_parser(line, file)

  unless line.nil?
    unless line.match(/"service":"(.*)","host/).nil? || line.match(/"metric":"(.*)","value/).nil? || line.match(/"value":(\d+),"/).nil?
      service = line.match(/"service":"(.*)","host/)[1]
      if service == 'middleManager'
        unless line.match(/"taskId":\["(.*)"\]}\]/).nil?
          service = line.match(/"taskId":\["(.*)"\]}\]/)[1]
        end
      end
      metric = (line.match(/"metric":"(.*)","value/)[1]).tr('/', '_')
      # puts metric
      value = line.match(/"value":(\d+),"/)[1]
    end
    unless service.nil? || value.nil?
      found1 = false
      found2 = false
      ttl1 = 3
      ttl2 = 3
      updated_here = false
      $metrics.each do |m|
        if m["metric"] == metric && m["service"] == service && m["num"] == 1
          found1 = true
          ttl1 = m["ttl"]
          puts "FOUND 1 Metric is #{m["metric"]} and its value is #{m["value"]}"
        end
      end
      if found1
        $metrics.each do |m|
          if m["metric"] == metric && m["service"] == service && m["num"] == 2
            found2 = true
            ttl2 = m["ttl"]
            puts "FOUND 2 Metric is #{m["metric"]} and its value is #{m["value"]}"
          end
        end
      end
      if found1 && found2
        if ttl2 >= ttl1
          $metrics.each do |m|
            if m["metric"] == metric && m["service"] == service && m["num"] == 1
              m["value"] = value
              m["ttl"] = 3
              m["iteration"] = $i
            end
          end
        else
          $metrics.each do |m|
            if m["metric"] == metric && m["service"] == service && m["num"] == 2
              m["value"] = value
              m["ttl"] = 3
              m["iteration"] = $i
            end
          end
        end
      end
      if !found1 || !found2
        if !found1
          num = 1
        end
        if found1 && !found2
          num = 2
        end
        $metrics << {
          "metric" => metric,
          "service" => service,
          "value" => value,
          "ttl" => 3,
          "iteration" => $i,
          "num" => num
        }
        puts metric + ' is added with value: ' + value
      end
    end
  end
end

def log_handler_druid(filename)
  File.open(filename, 'r') do |log|
    log.extend(File::Tail)
    log.backward(1)
    log.tail { |line| druid_parser(line, filename) }
  end
end
