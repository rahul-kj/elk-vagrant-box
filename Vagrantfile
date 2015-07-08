# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/vivid64"

  config.vm.network :forwarded_port, guest: 5601, host: 5601
  config.vm.network :forwarded_port, guest: 5000, host: 5000

  config.vm.provider "virtualbox" do |v|
  	v.memory = 2048
  	v.cpus = 1
  end

  config.vm.provider "vmware_fusion" do |v|
    v.memory  = 2048
    v.cpus = 1
  end

  config.vm.provision "shell", path: "scripts/install_config.sh /vagrant 192.168.0.1"

 end
