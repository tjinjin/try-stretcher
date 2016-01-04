# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.1"
  config.ssh.insert_key = false

  config.vm.define :app1 do |app1|
    app1.vm.network "private_network", ip: "192.168.34.42"
    app1.cache.scope = :box if Vagrant.has_plugin? 'vagrant-cachier'
  end
  config.vm.define :app2 do |app2|
    app2.vm.network "private_network", ip: "192.168.34.43"
    app2.cache.scope = :box if Vagrant.has_plugin? 'vagrant-cachier'
  end

  config.vm.define :app3 do |app3|
    app3.vm.network "private_network", ip: "192.168.34.44"
    app3.cache.scope = :box if Vagrant.has_plugin? 'vagrant-cachier'
  end
end

