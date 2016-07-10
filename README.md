mqtt_epoch_pub.rb 
====
![img01.png](img01.png)

how to use
----
    
    $ sudo gem install mqtt
    $ cd ~
    $ mkdir -p work
    $ cd work
    $ git clone https://github.com/yoggy/mqtt_epoch_pub.git
    $ cd mqtt_epoch_pub
    $ cp mqtt_config.yaml.sample mqtt_config.yaml
    $ vi mqtt_config.yaml

        host:     mqtt.example.com
        port:     1883
        use_auth: true
        username: username
        password: password
        topic: 
          - publish_topic1
          - publish_topic2
          - publish_topic3
      
    $ ruby mqtt_epoch_pub.rb

for supervisor
----
    $ cd ~/work/mqtt_epoch_pub
    $ cp sudo cp mqtt_epoch_pub.conf.sample /etc/supervisor/conf.d/mqtt_epoch_pub.conf
    $ sudo vi /etc/supervisor/conf.d/mqtt_epoch_pub.conf
      (fix path, etc...)
    $ sudo supervisorctl reread
    $ sudo supervisorctl add mqtt_epoch_pub
    $ sudo supervisorctl status
    mqtt_epoch_pub           RUNNING    pid 8192, uptime 0:00:30

