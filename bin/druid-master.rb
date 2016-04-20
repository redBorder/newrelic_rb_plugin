require_relative 'tail_f'

def druid_master
  threads = []
  Dir.glob('/var/log/druid/*.log') do |log_file|
    puts "Started At #{Time.now} with file: " + log_file
    binding.pry

    t = Thread.new do
      $var += 10
      binding.pry

      log_handler(log_file)
    end
    threads << t
  end
#  threads.each { |thread| thread.join }
end

def recolector
  $metrics.each do |m|
    puts "Metric is #{m["metric"]},
    value: #{m["value"]},
    service #{m["service"]},
    ttl:  #{m["ttl"]},
    iteration: #{m["iteration"]}"
    if ($i - m["iteration"]) % 20 == 0 && m["ttl"] >=0
      puts "Múltiplo de 20"
      m["ttl"] = m["ttl"] - 1

      if (m["ttl"] > 0)
        report_metric  m["metric"] + '_' + m["service"] + '_' + host, 'Value', m["value"]
        puts 'REPORTED:' + m["metric"] + '_' + m["service"] + '_' + host + 'Value: ' + m["value"]

      end
    end
  end
end

# Show the values every 5 seconds
=begin
Thread.new do
  $i=1
  loop do
    puts '------------------------- iteration = ' + $i.to_s
    recolector
    sleep 5
    $i=$i+1
  end
end

$metrics = []

druid_master
=end
