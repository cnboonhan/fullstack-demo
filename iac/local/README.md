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

### Provisioning

##### Local

```
cd local
mkdir .lxd-pools/app-cluster-pool .lxd-pools/gitlab-cluster-pool -p
ssh-keygen # ~/.ssh/id_rsa.pub to be copied into LXC containers for ssh access

tofu init
tofu apply -parallelism=1   # Handle race condition in tofu apply during ssh key copy
```
