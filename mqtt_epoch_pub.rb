#!/usr/bin/ruby

require 'mqtt'
require 'yaml'

$stdout.sync = true

$log = Logger.new(STDOUT)
$log.level = Logger::DEBUG

$mqtt_conf = YAML.load_file(File.dirname($0) + '/mqtt_config.yaml')

conn_opts = {
    "remote_host" => $mqtt_conf["host"],
    "remote_port" => 21883
}
if $mqtt_conf["use_auth"]
  conn_opts["username"] = $mqtt_conf["username"]
  conn_opts["password"] = $mqtt_conf["password"]
end

def prime?(n)
  return false if n < 2
  return true  if n == 2
  return false if n % 2 == 0

  i = 3
  while i < Math.sqrt(n)
    return false if n % i == 0
    i += 2
  end

  true
end


begin
  MQTT::Client.connect(conn_opts) do |c|
    loop do

      st = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }

  	  t = Time.now.to_i % 10000
  	  num_str = sprintf("segd%04d", t)
  	  num_str += "." if prime?(t)
  
      $mqtt_conf["topic"].each do |topic|
        c.publish(topic, num_str)
        $log.info "publish : topic=#{topic}, message=#{num_str}"
      end

      sleep 0.2

      et = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
      diff = et - st

      sleep (1000 - diff) / 1000.0 if 0 < diff && diff < 1000
    end
  end
resque Exception => e
  puts e
  puts e.backgrace
  sleep 5
end 
