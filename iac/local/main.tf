module "kubernetes-cluster" {
  source   = "./lxc-cluster"
  xs_label = "app-cluster"
  xs_image = "ubuntu:22.04"

  xs_network = {
    name = "xsbr0"
    ipv4 = {
      "address" : "192.168.42.1/24"
    }
  }

  xs_profiles = [
    {
      name = "kubernetes-master"
      limits = {
        cpu    = 1
        memory = "1GiB"
      }
    },
    {
      name = "kubernetes-worker"
      limits = {
        cpu    = 2
        memory = "2GiB"
      }
    }
  ]

  xs_instances = [
    {
      name    = "master-01"
      profile = "kubernetes-master"
      ip      = "192.168.42.11"
    },
    {
      name    = "master-02"
      profile = "kubernetes-master"
      ip      = "192.168.42.12"
    },
    {
      name    = "worker-01"
      profile = "kubernetes-worker"
      ip      = "192.168.42.21"
    },
    {
      name    = "worker-02"
      profile = "kubernetes-worker"
      ip      = "192.168.42.22"
    },
  ]

}

module "gitlab-cluster" {
  source   = "./lxc-cluster"
  xs_label = "gitlab-cluster"
  xs_image = "ubuntu:22.04"

  xs_network = {
    name = "xsbr1"
    ipv4 = {
      "address" : "192.168.43.1/24"
    }
  }

  xs_profiles = [
    {
      name = "gitlab-master"
      limits = {
        cpu    = 2
        memory = "4GiB"
      }
    }
  ]

  xs_instances = [
    {
      name    = "master-01"
      profile = "gitlab-master"
      ip      = "192.168.43.11"
    }
  ]
}