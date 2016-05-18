require 'file-tail'

def nginx_parser(line, file)
  unless line.nil?
    unless line.match(/HTTP\/[1-9].[1-9]" ()?\d+/).to_s.split(" ")[1].nil?
      status = line.match(/HTTP\/[1-9].[1-9]" ()?\d+/).to_s.split(" ")[1]
    end
    unless status.nil?
      found = false
      $nginx.each do |m|
        if m["status"] == status
          found = true
          m["times"] += 1
        end
      end
      if !found
        $nginx << {
          "status" => status,
          "times" => 1
        }
      end
    end
  end
end

def log_handler_nginx(filename)
  File.open(filename, 'r') do |log|
    log.extend(File::Tail)
    log.backward(1)
    log.tail { |line| nginx_parser(line, filename) }
  end
end
