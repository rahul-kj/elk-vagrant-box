# !/bin/bash

export CONFIG_ROOT_DIR=$1
export IP=$2

export ELASTIC_SEARCH_VERSION=1.6
export LOG_SEARCH_VERSION=1.5
export KIBANA_VERSION=4.1.1

sudo apt-get update && sudo apt-get install openssh-server && sudo service ssh restart

sudo ufw disable
sudo add-apt-repository -y ppa:webupd8team/java

wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elasticsearch.org/elasticsearch/$ELASTIC_SEARCH_VERSION/debian stable main" | sudo tee /etc/apt/sources.list.d/elasticsearch.list
echo "deb http://packages.elasticsearch.org/logstash/$LOG_SEARCH_VERSION/debian stable main" | sudo tee /etc/apt/sources.list.d/logstash.list

sudo apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer

sudo apt-get -y install elasticsearch
sudo sed -i.bak -e 's/#network.host: 192.168.0.1/network.host: localhost/g' /etc/elasticsearch/elasticsearch.yml #Set network.host: localhost
sudo service elasticsearch restart
sudo update-rc.d elasticsearch defaults enable 96 7

cd ~; wget https://download.elasticsearch.org/kibana/kibana/kibana-$KIBANA_VERSION-linux-x64.tar.gz
tar xvf kibana-*.tar.gz
sudo sed -i.bak -e "s/host: \"0.0.0.0\"/network.host: $IP/g" ~/kibana-4*/config/kibana.yml
sudo mkdir -p /opt/kibana
sudo cp -R ~/kibana-4*/* /opt/kibana/
cd /etc/init.d && sudo wget https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/bce61d85643c2dcdfbc2728c55a41dab444dca20/kibana4
sudo chmod +x /etc/init.d/kibana4
sudo update-rc.d kibana4 defaults enable 97 6
sudo service kibana4 start

sudo apt-get install logstash
sudo cp $CONFIG_ROOT_DIR/config/logstash-filter.conf /etc/logstash/conf.d/logstash-filter.conf
sudo service logstash restart
sudo update-rc.d logstash defaults enable 98 5

sudo service elasticsearch start
sudo service kibana4 start
sudo service logstash start
