def check_master(services)
  services.each { |x|
    $logger.debug(x + ' service checked')
    puts 'before'
    cmd = 'cat /tmp/rb_check.lock 2> /dev/null | xargs kill -9 2> /dev/null;
    rb_check -s ' + x + ' 2> /dev/null | grep FAILED | wc -l'
    value = `#{cmd}`
    puts 'after'
    status = (value.strip != '0') ? 0 : 1
    # puts 'service is ' + x + ' value: ' + value + ' then status is ' + status.to_s
    found = false

    $check.each do |m|
      if m['service'] == x
        found = true
        m['value'] = status
      end
    end
    if !found
      $check << {
        'service' => x,
        'value' => status
      }
    end
  }
end
