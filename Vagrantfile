# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider :libvirt do |v|
    v.memory = 2048

    v.storage :file, :size => "1G" # vdb
    v.storage :file, :size => "1G" # vdc
    v.storage :file, :size => "1G" # vdd
    v.storage :file, :size => "1G" # vde
    v.storage :file, :size => "1G" # vdf
    # v.linked_clone = true
  end

  config.vm.define "homelab-thinkcentre" do |sys|
    sys.vm.hostname = "homelab-thinkcentre"
    sys.vm.network :private_network, ip: "192.168.1.68", netmask: "255.255.255.0"
    sys.vm.network :forwarded_port, guest: 30080, host: 6880
    sys.vm.network :forwarded_port, guest: 30443, host: 6840
  end

  config.vm.define "homelab-mainarray" do |sys|
    sys.vm.hostname = "homelab-mainarray"
    sys.vm.network :private_network, ip: "192.168.1.69", netmask: "255.255.255.0"
    sys.vm.network :forwarded_port, guest: 30080, host: 6980
    sys.vm.network :forwarded_port, guest: 30443, host: 6940

    # sys.vm.disk :disk, size: "1GB", name: "b"
    # sys.vm.disk :disk, size: "1GB", name: "c"
    # sys.vm.disk :disk, size: "1GB", name: "d"
    # sys.vm.disk :disk, size: "1GB", name: "e"
    # sys.vm.disk :disk, size: "1GB", name: "f"
  end

  # config.vm.provision "ansible" do |ansible|
  #     ansible.playbook = "setup-lab.yml"
  # end
end
