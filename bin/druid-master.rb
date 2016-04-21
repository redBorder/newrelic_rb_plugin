require_relative 'tail_f'

def druid_master
  threads = []
  Dir.glob('/var/log/druid/*.log') do |log_file|
    puts "Started At #{Time.now} with file: " + log_file

    t = Thread.new do
      $var += 10

      log_handler(log_file)
    end
    threads << t
  end
#  threads.each { |thread| thread.join }
end

def recolector
  $metrics.each do |m|
    if (m["ttl"] == 0)
      $metrics.delete(m)
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
