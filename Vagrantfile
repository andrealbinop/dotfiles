# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/jammy64"
  end
  config.vm.define "macos" do |macos|
    macos.vm.box = "macos/catalina"
    macos.vm.synced_folder ".", "/Users/vagrant/vagrant", type: "rsync",
      rsync__exclude: ".git/",
      rsync__group: "staff"
  end
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "1536"
    vb.customize ["modifyvm", :id, "--vram", "128"]
  end
end
