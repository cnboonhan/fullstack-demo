# Configuration Setup Guide

### Prerequisites

##### Ansible

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

##### SSH Access

```
# localhost should be able to run the following without error 
ansible all -m ping -i inventory.ini

# Every account should be also able to run commands without sudo prompts. In /etc/sudoers :
user ALL=(ALL) NOPASSWD: ALL 
```

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
ansible-playbook kubecluster-playbook.yml -i inventory.ini
```
