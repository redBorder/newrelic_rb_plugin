require_relative 'tail_f_chef'

def chef_master
  threads = []
    log_file = '/var/log/chef-client/current'
    puts "Started At #{Time.now} with file: " + log_file.to_s
    t = Thread.new do
      log_handler_chef(log_file)
    end
    threads << t
end

def chef_recolector
  $chef.each do |m|
      $chef.delete(m)
  end
end
