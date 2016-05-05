def cpu(manager)
  response = manager.get(['1.3.6.1.4.1.2021.11.9.0'])
  response.each_varbind do |vb|
    unless vb.nil?
      # puts "#{vb.name.to_s}
      #{vb.value.to_s}  #{vb.value.asn1_type}" unless vb.nil?
      return vb.value.to_f
    end
  end
end

def mem_total(manager)
  response = manager.get(['1.3.6.1.4.1.2021.4.5.0'])
  response.each_varbind do |vb|
    unless vb.nil?
      # puts "#{vb.name.to_s}
      #{vb.value.to_s}  #{vb.value.asn1_type}" unless vb.nil?
      return vb.value.to_f
    end
  end
end

def mem_free(manager)
  response = manager.get(['1.3.6.1.4.1.2021.4.6.0'])
  response.each_varbind do |vd|
    # puts "#{vd.name.to_s}  #{vd.value.to_s}  #{vd.value.asn1_type}" unless vd.nil?
    return vd.value.to_i
  end
end

def mem_total_buffer(manager)
  response = manager.get(["1.3.6.1.4.1.2021.4.14.0"])
  response.each_varbind do |vd|
    # puts "#{vd.name.to_s}  #{vd.value.to_s}  #{vd.value.asn1_type}" unless vd.nil?
    return vd.value.to_i
  end
end

def mem_total_cache(manager)
  response = manager.get(["1.3.6.1.4.1.2021.4.15.0"])
  response.each_varbind do |vd|
    # puts "#{vd.name.to_s}  #{vd.value.to_s}  #{vd.value.asn1_type}" unless vd.nil?
    return vd.value.to_i
  end
end

def get_avio()
  return `(atop 2 2 | grep avio |  awk '{print $15}' |
  paste -s -d'+' | sed 's/^/scale=3; (/' | sed 's|$|)/2|' | bc)`
end

def disk_percent(manager)
  response = manager.get(["1.3.6.1.4.1.2021.9.1.9.1"])
  response.each_varbind do |vd|
    # puts "#{vd.name.to_s}  #{vd.value.to_s}  #{vd.value.asn1_type}" unless vd.nil?
    return vd.value.to_i
  end
end

def disk_load
  return `(snmptable -v 2c -c redBorder 127.0.0.1 diskIOTable|grep ' dm-0 ' | awk '{print $7}')`.strip.to_i
end

def memory_total_druid_broker
  return `(sudo /opt/rb/bin/rb_mem.sh -f /opt/rb/var/sv/druid_broker/supervise/pid 2>/dev/null)`.strip.to_i
end

def memory_total_druid_coordinator
  return `sudo /opt/rb/bin/rb_mem.sh -f /opt/rb/var/sv/druid_coordinator/supervise/pid 2>/dev/null`.strip.to_i
end

def memory_total_druid_historical
  return `sudo /opt/rb/bin/rb_mem.sh -f /opt/rb/var/sv/druid_historical/supervise/pid 2>/dev/null`.strip.to_i
end

def memory_total_druid_realtime
  return `sudo /opt/rb/bin/rb_mem.sh -f /opt/rb/var/sv/druid_realtime/supervise/pid 2>/dev/null`.strip.to_i
end

def memory_total_kafka
  return `sudo /opt/rb/bin/rb_mem.sh -f /opt/rb/var/sv/kafka/supervise/pid 2>/dev/null`.strip.to_i
end

def memory_total_nprobe
  return `sudo /opt/rb/bin/rb_mem.sh -f
  /opt/rb/var/sv/nprobe/supervise/pid 2>/dev/null`.strip.to_i
end

def memory_total_postgresql
  return `sudo /opt/rb/bin/rb_mem.sh -f /opt/rb/var/sv/postgresql/supervise/pid 2>/dev/null`.strip.to_i
end

def memory_total_rbwebui
  return `sudo /opt/rb/bin/rb_mem.sh -f /opt/rb/var/sv/rb-webui/supervise/pid 2>/dev/null`.strip.to_i
end

def memory_total_zookeeper
  return `sudo /opt/rb/bin/rb_mem.sh -f /opt/rb/var/sv/zookeeper/supervise/pid 2>/dev/null`.strip.to_i
end

def latency
  return `nice -n 19 fping -q -s fcojriosbello 2>&1| grep 'avg round trip time'| awk '{print $1}'`.strip.to_i
end

def pkts_rcv
  return 100 - `sudo /bin/nice -n 19 /usr/sbin/fping -p 1 -c 10 fcojriosbello 2>&1 | tail -n 1 | awk '{print $5}' | sed 's/%.*$//' | tr '/' ' ' | awk '{print $3}'`.strip.to_i
end
