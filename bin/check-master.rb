def check_master(services)
  services.each { |x|
    filename = '/opt/rb/etc/rb_check.d/rb_check_' + x.to_s + '.sh'
    if File.file?(filename)
      $logger.debug(x + " service checked")
      cmd = "lib/rb_nr_check " + x
      value = `#{cmd}`
      returned = $?

      found = false
      $check.each do |m|
        if m["service"] == x
          found = true
          m["value"] = returned.to_s.split(' ')[3]
        end
      end
      if !found
        $check << {
          "service" => x,
          "value" => returned.to_s.split(' ')[3]
        }
      end
    else
      puts x.to_s + ' service doesn\'t have a check script'
      next
    end
  }
end
