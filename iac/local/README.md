# Infrastructure Setup Guide

## Prerequisites

##### LXD ( Local )

```
sudo snap install lxd
```

##### OpenTofu

```
snap install --classic opentofu
```

##### Ansible

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## Provisioning and Configuration

### Provisioning

##### Local

```
cd local
mkdir .lxd-pools/app-cluster-pool .lxd-pools/gitlab-cluster-pool -p
ssh-keygen # ~/.ssh/id_rsa.pub to be copied into LXC containers for ssh access

tofu init
tofu apply 
```

##### Cloud

(In progress...)

### Configuration

```
cd configuration
ansible all -m ping -i inventory.ini
```
