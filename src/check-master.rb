def check_master(service)
    $logger.debug(service + ' service checked')

    cmd = 'lib/rb_nr_check ' + service
    value = `#{cmd}`
    status = ($?.to_s.split(' ')[3] == '1') ? 0 : 1
    puts 'service is ' + service + ' then status is ' + status.to_s


    found = false

    $check.each do |m|
      if m['service'] == service
        found = true
        m['value'] = status
      end
    end
    if !found
      $check << {
        'service' => service,
        'value' => status
      }
    end
end
