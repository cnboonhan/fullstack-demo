# Infrastructure Setup Guide

## Prerequisites

##### LXD ( Local )

```
sudo snap install lxd
su $USER # Or re-login
lxd init # Defaults for everything
```

##### OpenTofu

```
sudo snap install --classic opentofu
```

### Provisioning

##### Local

```
cd local
mkdir .lxd-pools/app-cluster-pool .lxd-pools/gitlab-cluster-pool -p
ssh-keygen # ~/.ssh/id_rsa.pub to be copied into LXC containers for ssh access

tofu init
tofu apply -parallelism=1   # Handle race condition in tofu apply during ssh key copy

# Note that if you have Docker on your machine, there might networking issues
# Set the following in /etc/docker/daemon.json
# { "iptables": false }
```
