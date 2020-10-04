# vagrant-kvm-k8s-setup

This is a Work in Progress Repository.

The idea is to spin a Kubernetes Cluster with libvirt and vagrant.

This is tested on Debian 10 System.


## Prerequisites
1. libvirt KVM
2. vagrant


## Known Issues

The Master has to spin up first and then the minions.
The KVM is quite fast in spinning the nodes hence the Minions will not start unless the master is running.

As a workaround the startup is a two step process
`vagrant ssh k8s-master-1`

Once the Master is started issue the following command to bootstrap the minions
`vagrant up k8s-minion-1 k8s-minion-2 k8s-minion-3`


Installing KVM & Vagrant
1. `sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils libguestfs-tools genisoimage virtinst libosinfo-bin vagrant vagrant-libvirt vagrant-mutate vagrant-sshfs python3-vagrant `

2. Allow normal user to manage virtual machine
  `$ sudo adduser ${whoami} libvirt
  $ sudo adduser ${whoami} libvirt-qemu
  `
