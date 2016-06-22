require 'file-tail'

def chef_parser(line)
  unless line.nil?
    unless line.match(/ERROR:(.*)/).to_s.nil?
      matched = line.match(/ERROR:(.*)/).to_s
      error = (matched.include? 'retry') ? matched.split(',')[0] : matched
#      puts error unless error.empty?
    end
    unless error.nil? || error.empty?
      found = false
      $chef.each do |m|
        if m["error"] == error
          found = true
          m["times"] = 1
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

def log_handler_chef(filename)
  File.open(filename, 'r') do |log|
    log.extend(File::Tail)
    log.backward(1)
    log.tail { |line| chef_parser(line) }
  end
end
