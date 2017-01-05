#/bin/bash

case $1 in

  install)

    sudo apt-get -qq update
    sudo apt-get -y install apt-transport-https ca-certificates unzip
    sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get -qq update
    sudo apt-get -y install docker-engine
    sudo service docker start
    sudo curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    unzip ./code.zip -d .
    cd code
    echo "Installation complete. Run 'install.sh start' to start the Drupal cluster."

  create)

    sudo docker-compose up

  start)

    sudo docker-compose pause haproxy
    sudo docker-compose pause drupal1
    sudo docker-compose pause drupal2
    sudo docker-compose pause drupal3
    sudo docker-compose pause db

  stop)

    sudo docker-compose unpause haproxy
    sudo docker-compose unpause drupal1
    sudo docker-compose unpause drupal2
    sudo docker-compose unpause drupal3
    sudo docker-compose unpause db

  destroy)

    sudo docker-compose down --volumes

  *)
  echo "Usage: ${JOB}_ctl {install|create|start|stop|destroy}" ;;

esac
exit 0
