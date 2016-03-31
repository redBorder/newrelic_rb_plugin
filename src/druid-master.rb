require_relative 'tail_f'

threads = []

Dir.glob('/var/log/druid/*.log') do |log_file|
  puts "Started At #{Time.now} with file: " + log_file
  t = Thread.new do
  log_handler(log_file)
  end
  threads << t
end

threads.each { |thread| thread.join }
