def chef_master
  threads = []
  Dir.glob('/var/log/chef-client/current') do |log_file|
    puts "Started At #{Time.now} with file: " + log_file.to_s
    t = Thread.new do
      log_handler(log_file)
    end
    threads << t
  end
end

def chef_parser(line)
  unless line.nil?
    unless line.match(/ERROR:(.*)/).to_s.nil?
      error = line.match(/ERROR:(.*)/).to_s
    end
    unless error.nil?
      found = false
      $chef.each do |m|
        if m["error"] == error
          found = true
          m["times"] += 1
        end
      end
      if !found
        $chef << {
          "error" => error,
          "times" => 1
        }
      end
    end
  end
end

def log_handler(filename)
  chef = File.open(filename, 'r').read
    chef.gsub!(/\r\n?/, "\n")
    chef.each_line do |line|
      cheff_parser(line, filename)
    end
  end
end
