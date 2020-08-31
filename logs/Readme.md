Docker Logs methodology

    1. Specify the container
    2. All container

# 1. Specify the container
    docker run \
      --log-driver syslog --log-opt syslog-address=udp://127.0.0.1:514 \
      alpine echo hello world

# 2. All container


# Install Rsyslog service

    $ sudo apt update && sudo apt install rsyslog
    $ vim /etc/rsyslog.conf 
    $ sudo vim /etc/rsyslog.conf

    # Uncomment the lines
    module(load="imudp")
    input(type="imudp" port="514")

    $ sudo systemctl restart rsyslog


# Change the log direction into syslog

    $ sudo vim /etc/docker/daemon.json
    {
    "log-driver": "syslog",
    "log-opts": {
        "syslog-address": "udp://127.0.0.1:514"
    }
    }

# restart the docker sevice

    $ sudo systemctl restart docker
    $ sudo systemctl status docker


