
def druid_parser
  Dir.glob('*.log') do |log_file|
    File.open(log_file, 'r') do |file|
      file.each_line do |line| unless line.nil?
        service = line.match(/"service":"(.*)","host/)[1] unless line.match(/"metric":"(.*)","value/).nil?
        metric = line.match(/"metric":"(.*)","value/)[1] unless line.match(/"metric":"(.*)","value/).nil?
        value = line.match(/"value":(\d+),"/)[1] unless line.match(/"value":(\d+),"/).nil?

      #  puts "Service is #{service}, Metric is #{metric} and its value is #{value}" unless service.nil?
        if service == 'realtime'
          realtime(metric, value)
        elsif service == 'coordinator'
          coordinator(metric, value)
        elsif service == 'broker'
          broker(metric, value)
        elsif service == 'historical'
          historical(metric,value)
        end
      end
    end
  end
end
end

def realtime(metric, value)
  if metric == 'jvm/pool/committed'
    @realtime_jvm_pool_commited = value
  elsif metric == 'jvm/pool/init'
    @realtime_jvm_pool_init = value
  elsif metric == 'jvm/pool/used'
    @realtime_jvm_pool_used = value
  elsif metric == 'jvm/pool/max'
    @realtime_jvm_pool_max = value
  elsif metric == 'jvm/bufferpool/used'
    @realtime_jvm_bufferpool_used = value
  elsif metric == 'jvm/bufferpool/count'
    @realtime_jvm_bufferpool_count = value
  elsif metric == 'jvm/bufferpool/capacity'
    @realtime_jvm_bufferpool_capacity = value
  elsif metric == 'jvm/mem/init'
    @realtime_jvm_mem_init = value
  elsif metric == 'jvm/mem/max'
    @realtime_jvm_mem_max = value
  elsif metric == 'jvm/mem/used'
    @realtime_jvm_mem_used = value
  elsif metric == 'jvm/mem/commited'
    @realtime_jvm_mem_commited = value
  elsif metric == 'jvm/gc/count'
    @realtime_jvm_gc_count = value
  elsif metric == 'jvm/gc/time'
    @realtime_jvm_gc_time = value
  end
end
def broker(metric, value)
  if metric == 'jvm/pool/committed'
    @broker_jvm_pool_commited = value
  elsif metric == 'jvm/pool/init'
    @broker_jvm_pool_init = value
  elsif metric == 'jvm/pool/used'
    @broker_jvm_pool_used = value
  elsif metric == 'jvm/pool/max'
    @broker_jvm_pool_max = value
  elsif metric == 'jvm/bufferpool/used'
    @broker_jvm_bufferpool_used = value
  elsif metric == 'jvm/bufferpool/count'
    @broker_jvm_bufferpool_count = value
  elsif metric == 'jvm/bufferpool/capacity'
    @broker_jvm_bufferpool_capacity = value
  elsif metric == 'jvm/mem/init'
    @broker_jvm_mem_init = value
  elsif metric == 'jvm/mem/max'
    @broker_jvm_mem_max = value
  elsif metric == 'jvm/mem/used'
    @broker_jvm_mem_used = value
  elsif metric == 'jvm/mem/commited'
    @broker_jvm_mem_commited = value
  elsif metric == 'jvm/gc/count'
    @broker_jvm_gc_count = value
  elsif metric == 'jvm/gc/time'
    @broker_jvm_gc_time = value
  end
end
def coordinator(metric, value)
  if metric == 'jvm/pool/committed'
    @coordinator_jvm_pool_commited = value
  elsif metric == 'jvm/pool/init'
    @coordinator_jvm_pool_init = value
  elsif metric == 'jvm/pool/used'
    @coordinator_jvm_pool_used = value
  elsif metric == 'jvm/pool/max'
    @coordinator_jvm_pool_max = value
  elsif metric == 'jvm/bufferpool/used'
    @coordinator_jvm_bufferpool_used = value
  elsif metric == 'jvm/bufferpool/count'
    @coordinator_jvm_bufferpool_count = value
  elsif metric == 'jvm/bufferpool/capacity'
    @coordinator_jvm_bufferpool_capacity = value
  elsif metric == 'jvm/mem/init'
    @coordinator_jvm_mem_init = value
  elsif metric == 'jvm/mem/max'
    @coordinator_jvm_mem_max = value
  elsif metric == 'jvm/mem/used'
    @coordinator_jvm_mem_used = value
  elsif metric == 'jvm/mem/commited'
    @coordinator_jvm_mem_commited = value
  elsif metric == 'jvm/gc/count'
    @coordinator_jvm_gc_count = value
  elsif metric == 'jvm/gc/time'
    @coordinator_jvm_gc_time = value
  end
end
def historical(metric, value)
  if metric == 'jvm/pool/committed'
    @historical_jvm_pool_commited = value
  elsif metric == 'jvm/pool/init'
    @historical_jvm_pool_init = value
  elsif metric == 'jvm/pool/used'
    @historical_jvm_pool_used = value
  elsif metric == 'jvm/pool/max'
    @historical_jvm_pool_max = value
  elsif metric == 'jvm/bufferpool/used'
    @historical_jvm_bufferpool_used = value
  elsif metric == 'jvm/bufferpool/count'
    @historical_jvm_bufferpool_count = value
  elsif metric == 'jvm/bufferpool/capacity'
    @historical_jvm_bufferpool_capacity = value
  elsif metric == 'jvm/mem/init'
    @historical_jvm_mem_init = value
  elsif metric == 'jvm/mem/max'
    @historical_jvm_mem_max = value
  elsif metric == 'jvm/mem/used'
    @historical_jvm_mem_used = value
  elsif metric == 'jvm/mem/commited'
    @historical_jvm_mem_commited = value
  elsif metric == 'jvm/gc/count'
    @historical_jvm_gc_count = value
  elsif metric == 'jvm/gc/time'
    @historical_jvm_gc_time = value
  end
end
