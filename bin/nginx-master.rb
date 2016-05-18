require_relative 'tail_f_nginx'

def nginx_master
  threads = []
  Dir.glob('/var/log/nginx/acc*.log') do |log_file|
    puts "Started At #{Time.now} with file: " + log_file.to_s
    t = Thread.new do
      log_handler_nginx(log_file)
    end
    threads << t
  end
end
