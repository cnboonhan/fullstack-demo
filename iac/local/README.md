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
tofu apply -parallelism=1   # Handle race condition in tofu apply during ssh key copy
```

##### Cloud

(In progress...)

### Configuration

```
# Gitlab and Docker
cd configuration
ansible all -m ping -i inventory.ini
ansible-playbook docker-playbook.yml  -i inventory.ini
ansible-playbook gitlab-playbook.yml  -i inventory.ini
```

```
# Kubernetes
cd configuration

# On Master
curl -sfL https://get.k3s.io | sh -
K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/token)

# On Workers
curl -sfL https://get.k3s.io | K3S_URL=https://[Server Ip]:6443 K3S_TOKEN=XXX sh -

# On Admin
lxc file pull app-cluster-master-01/etc/rancher/k3s/k3s.yaml /tmp/k3s.yaml
KUBECONFIG=/tmp/k3s.yaml kubectl get pods -A

```
