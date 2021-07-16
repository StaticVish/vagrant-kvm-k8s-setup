#!/bin/bash
set -e
IFNAME=eth0
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# remove ubuntu-bionic entry
sed -e '/^.*ubuntu.*.localdomain.*/d' -i /etc/hosts

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
192.168.5.11  k8s-master-1
192.168.5.12  k8s-master-2
192.168.5.13  k8s-master-3
192.168.5.14  k8s-master-4
192.168.5.15  k8s-master-5
192.168.5.21  k8s-minion-1
192.168.5.22  k8s-minion-2
192.168.5.23  k8s-minion-3
192.168.5.24  k8s-minion-4
192.168.5.25  k8s-minion-5
192.168.5.26  k8s-minion-6
192.168.5.27  k8s-minion-7
192.168.5.28  k8s-minion-8
192.168.5.29  k8s-minion-9
192.168.5.41  lb
EOF
