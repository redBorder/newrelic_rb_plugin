def check_master(services)
  services.each { |x|
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
  }
end
