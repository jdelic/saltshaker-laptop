# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "debian-13-amd64"
    config.vm.box_url = "https://s3.eu-central-1.amazonaws.com/vagrant.maurus.net/debian-13-amd64-libvirt.box"
    config.vm.provider :libvirt do |lv|
        #lv.customize ['modifyvm', :id, '--rtcuseutc', 'on']
        lv.memory = 4096
        lv.cpus = 4
    end
    config.vm.synced_folder ".", "/vagrant", type: "nfs",
                            linux__nfs_options: ['rw','no_subtree_check','all_squash','no_root_squash'],
                            nfs_version: 4,
                            nfs_udp: false
    config.ssh.forward_agent = true
end
