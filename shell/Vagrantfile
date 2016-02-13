# -*- mode: ruby -*-
# vi: set ft=ruby :

# Notes:
# Created to simply deployment of MariaDB, which comes with Galera.
# 1.
# Every Vagrant development environment requires a box. You can search for
# boxes at https://atlas.hashicorp.com/search.
# 2.
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-6.7"
  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.define "db1" do |db1|
    db1.vm.hostname = "db1"
    db1.vm.network "private_network", ip: "192.168.50.101"
  end 

  config.vm.define "db2" do |db2|
    db2.vm.hostname = "db2"
    db2.vm.network "private_network", ip: "192.168.50.102"
  end 

  config.vm.define "db3" do |db3|
    db3.vm.hostname = "db3"
    db3.vm.network "private_network", ip: "192.168.50.103"
  end 

  config.vm.provider "virtualbox" do |v| 
    v.memory = 1024
    v.cpus = 1 
  end 

  config.ssh.password = "vagrant"

  # config.vm.network :forwarded_port, guest: 80, host: 4567
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"

end
