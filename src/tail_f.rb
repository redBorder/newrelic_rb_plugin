require 'file-tail'

def druid_parser(line, file)
  unless line.nil?
    service = line.match(/"service":"(.*)","host/)[1] unless line.match(/"metric":"(.*)","value/).nil?
    metric = line.match(/"metric":"(.*)","value/)[1] unless line.match(/"metric":"(.*)","value/).nil?
    value = line.match(/"value":(\d+),"/)[1] unless line.match(/"value":(\d+),"/).nil?
      puts file + "Service is #{service}, Metric is #{metric} and its value is #{value}" unless (service.nil? || value.nil?)
  end
end

def log_handler(filename)
  File.open(filename, 'r') do |log|
    log.extend(File::Tail)
    log.backward(1)
    log.tail { |line| druid_parser(line, filename) }
  end
end
