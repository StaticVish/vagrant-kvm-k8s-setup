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
<pre><code>
  $ vagrant up k8s-master-1
</code></pre>

Once the Master is started issue the following command to bootstrap the minions
<pre><code>
  $ vagrant up k8s-minion-1 k8s-minion-2 k8s-minion-3
</code></pre>



1.Installing KVM & Vagrant
<pre><code>
    $ sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils libguestfs-tools genisoimage virtinst libosinfo-bin vagrant vagrant-libvirt vagrant-mutate vagrant-sshfs python3-vagrant
</code></pre>

2. Allow normal user to manage virtual machine
  <pre><code>
    $ sudo adduser `whoami` libvirt
    $ sudo adduser `whoami` libvirt-qemu
  </code></pre>

3. Read more on How to install on Debian [here](https://wiki.debian.org/KVM)


4. Debian 10 has an issue with lib-virt and vagrant has an issue. To Run the plugin install use the below command.

```
CFLAGS="-I/opt/vagrant/embedded/include/ruby-3.0.0/ruby" vagrant plugin install vagrant-libvirt vagrant-mutate vagrant-sshfs

```