require_relative 'tail_f'
#$mutex = Mutex.new

$metrics = []

def druid_master
  threads = []
  $i=1
  Dir.glob('/var/log/druid/*.log') do |log_file|
    puts "Started At #{Time.now} with file: " + log_file
    t = Thread.new do
      log_handler(log_file)
    end
    threads << t
  end
  threads.each { |thread| thread.join }
end

def recolector
  $metrics.each do |metric|
    puts $metrics.size
    +  'This: '
    + metric[:metric] + ' '
    + metric[:value] + ' '
    + metric[:ttl]
  end
end
items = []
one_at_a_time = Mutex.new

# Show the values every 5 seconds
Thread.new do
  i=1
  loop do
    puts '------------------------- i = ' + i.to_s
    recolector
    sleep 5
    i=i+1
  end
end
druid_master
