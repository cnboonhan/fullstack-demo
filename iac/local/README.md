# Local Infrastructure Setup

## Prerequisites

###### LXD

```
sudo snap install lxd
```

###### OpenTofu

```
snap install --classic opentofu
```

## Setup

```
mkdir .lxd-pools/app-cluster-pool .lxd-pools/gitlab-cluster-pool -p
tofu init
tofu apply 
```
