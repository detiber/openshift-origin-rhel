#!/bin/bash
set -eu

# Update system to latest packages and install dependencies
yum -y update
yum -y install wget git net-tools bind-utils iptables-services bridge-utils bash-completion pyOpenSSL

# Install epel-release if not already installed
rpm -q epel-release || yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# ensure epel repo is disabled by default
yum-config-manager epel --disable > /dev/null

# Install Ansible
yum -y --enablerepo=epel install ansible1.9

# Install Docker
yum -y install docker

# Create thin pool logical volume for Docker
cat >>/etc/sysconfig/docker-storage-setup <<EOF
DEVS=/dev/sdc
VG=docker-vg
EOF

# Enable and start Docker services
systemctl enable docker
systemctl start docker
