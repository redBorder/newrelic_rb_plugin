def check_master(services)
  services.each { |x|
    $logger.debug(x + ' service checked')
    # rb_check -s nginx | grep FAILED | wc -l
    cmd = 'rb_check -s ' + x + ' 2> /dev/null | grep FAILED | wc -l'
    value = `#{cmd}`
    # puts 'service is ' + x + ' value: ' + value

    status = (value != '0') ? 0 : 1
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
