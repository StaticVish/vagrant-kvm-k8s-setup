# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# OS_IMAGE = 'debian/buster64'
OS_IMAGE = 'generic/ubuntu2004'

IP_NW = '192.168.5.'

MASTER_IP_START = 10
NODE_IP_START = 20
LB_IP_START = 40

NUM_MASTER_NODE = 1
NUM_MINIONS_NODE = 3
NUM_LB_NODE = 1


Vagrant.configure("2") do |config|

  config.ssh.insert_key = false

  # Provision Master Nodes
  (1..NUM_MASTER_NODE).each do |i|
    config.vm.define "k8s-master-#{i}" do |master|
      master.vm.box = OS_IMAGE
      master.vm.hostname = "k8s-master-#{i}"      
      master.vm.network :private_network,
        :ip => IP_NW + "#{MASTER_IP_START + i}"
      master.vm.provider :libvirt do |v|
        v.qemu_use_session = false
        v.memory = 2048
        v.cpus= 2
      end
      master.vm.provision "shell", path: "k8s-setup/setup-dns.sh"
      master.vm.provision "shell", inline: "sudo DEBIAN_FRONTEND=noninteractive  apt-get update -y && sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && sudo DEBIAN_FRONTEND=noninteractive  apt-get dist-upgrade -y && sudo DEBIAN_FRONTEND=noninteractive  apt-get -y install ansible"
      master.vm.provision 'ansible' do |ansible|
        ansible.verbose = true
        ansible.become = true
        ansible.compatibility_mode = 'auto'
        ansible.playbook = 'k8s-setup/k8s-master-setup.yaml'
        ansible.extra_vars = {
          ansible_python_interpreter: '/usr/bin/python3',
        }
      end
    end
  end

  # Provision Worker Nodes
  (1..NUM_MINIONS_NODE).each do |i|
    config.vm.define "k8s-minion-#{i}", autostart: false do |node|
      node.vm.box = OS_IMAGE
      node.vm.hostname = "k8s-minion-#{i}"            
      node.vm.network :private_network,
        :ip =>  IP_NW + "#{NODE_IP_START + i}"
      node.vm.provider :libvirt do |v|
        v.qemu_use_session = false
        v.memory = 1024
        v.cpus= 1
      end
      node.vm.provision "shell", path: "k8s-setup/setup-dns.sh"
      node.vm.provision "shell", inline: "sudo DEBIAN_FRONTEND=noninteractive  apt-get update -y && sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && sudo DEBIAN_FRONTEND=noninteractive  apt-get dist-upgrade -y && sudo DEBIAN_FRONTEND=noninteractive  apt-get -y install ansible"
      node.vm.provision "ansible" do |ansible|
        ansible.verbose = true
        ansible.become = true
        ansible.compatibility_mode ="auto"
        ansible.playbook = "k8s-setup/k8s-node-setup.yaml"
        ansible.extra_vars = {
          # node_ip: "192.168.50.#{i + 10}",
          ansible_python_interpreter: "/usr/bin/python3",
        }
      end
    end
  end

  # Provision LB Nodes
  (1..NUM_LB_NODE).each do |i|
    config.vm.define "lb-#{i}" do |lb|
      lb.vm.box = OS_IMAGE
      lb.vm.hostname = "lb-#{i}"
      lb.vm.network :private_network,
        :ip => IP_NW + "#{LB_IP_START + i}"
      lb.vm.provider :libvirt do |v|
        v.qemu_use_session = false
        v.memory = 2048
        v.cpus= 2
      end
      lb.vm.provision "shell", path: "k8s-setup/setup-dns.sh"
      lb.vm.provision "shell", inline: "sudo DEBIAN_FRONTEND=noninteractive  apt-get update -y && sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && sudo DEBIAN_FRONTEND=noninteractive  apt-get dist-upgrade -y && sudo DEBIAN_FRONTEND=noninteractive  apt-get -y install ansible"
      # lb.vm.provision 'ansible' do |ansible|
      #   ansible.verbose = true
      #   ansible.become = true
      #   ansible.compatibility_mode = 'auto'
      #   ansible.playbook = 'k8s-setup/k8s-master-setup.yaml'
      #   ansible.extra_vars = {
      #     ansible_python_interpreter: '/usr/bin/python3',
      #   }
      # end
    end
  end
end
