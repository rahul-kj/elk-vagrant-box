## Spinning up a vagrant vm with ELK (ElasticSearch, Logstash and Kibana)

Please edit VagrantFile and set the desired IP for you VM.

Execute `vagrant up` and enjoy ELK.

If you're not using vagrant and want to install ELK on ubuntu 14.04 or 15.04, then clone this repo, and execute `./scripts/install_config.sh [CONFIG_ROOT_DIR] [VM_IP_ADDRESS]`

`CONFIG_ROOT_DIR` is path to the <git-clone-dir>/elk-vagrant-box directory

`VM_IP_ADDRESS` is the ip address of your ubuntu machine.

Logstash port are open on 5000 and 8000 (TCP and UDP) for type - syslog
Kibana port is 5601
