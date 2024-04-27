# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider :libvirt do |v|
    v.memory = 4096
    v.cpus = 2

    v.storage :file, :size => "1G" # vdb
    v.storage :file, :size => "1G" # vdc
    v.storage :file, :size => "1G" # vdd
    v.storage :file, :size => "1G" # vde
    v.storage :file, :size => "1G" # vdf, cache
  end

  config.vm.define "mainarray" do |sys|
    sys.vm.hostname = "mainarray"
    sys.vm.network :private_network, ip: "192.168.1.68", netmask: "255.255.255.0"
    sys.vm.network :forwarded_port, guest: 30080, host: 6880
    sys.vm.network :forwarded_port, guest: 30443, host: 6840
  end

  # config.vm.define "mainarray" do |sys|
  #   sys.vm.hostname = "mainarray"
  #   sys.vm.network :private_network, ip: "192.168.1.69", netmask: "255.255.255.0"
  #   sys.vm.network :forwarded_port, guest: 30080, host: 6980
  #   sys.vm.network :forwarded_port, guest: 30443, host: 6940
  # end
end
