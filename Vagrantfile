# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  config.vm.box = "generic/debian10"
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider :virtualbox do |v|
    v.memory = 2048
    v.linked_clone = true
  end

  config.vm.define "homelab-thinkcentre" do |sys|
    sys.vm.hostname = "homelab-thinkcentre"
    sys.vm.network :private_network, ip: "192.168.56.68"
    sys.vm.network :forwarded_port, guest: 30000, host: 6880
  end

  config.vm.define "homelab-mainarray" do |sys|
    sys.vm.hostname = "homelab-mainarray"
    sys.vm.network :private_network, ip: "192.168.56.69"
    sys.vm.network :forwarded_port, guest: 30000, host: 6980
    sys.vm.disk :disk, size: "1GB", name: "b"
    sys.vm.disk :disk, size: "1GB", name: "c"
    sys.vm.disk :disk, size: "1GB", name: "d"
    sys.vm.disk :disk, size: "1GB", name: "e"
  end

  # config.vm.provision "ansible" do |ansible|
  #     ansible.playbook = "setup-lab.yml"
  # end
end
