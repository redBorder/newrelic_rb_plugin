require_relative 'tail_f'

def druid_master
  threads = []
  Dir.glob('/var/log/druid/*.log') do |log_file|
    puts "Started At #{Time.now} with file: " + log_file
    t = Thread.new do
      log_handler(log_file)
    end
    threads << t
  end
  Dir.glob('/tmp/druid-indexing/persistent/tasks/index_*/log') do |log_file|
    puts "Started At #{Time.now} with file: " + log_file
    t = Thread.new do
      log_handler(log_file)
    end
    threads << t
  end
end

def recolector
  $metrics.each do |m|
    if (m["ttl"] == 0)
      $metrics.delete(m)
    end
  end
end
