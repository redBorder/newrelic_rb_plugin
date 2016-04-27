require_relative 'tail_f_nginx'

def nginx_master
  threads = []
  File.open('/var/log/nginx/access.log') do |log_file|
    puts "Started At #{Time.now} with file: " + log_file
    t = Thread.new do
      log_handler(log_file)
    end
    threads << t
  end
end
