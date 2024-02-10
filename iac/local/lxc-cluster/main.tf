# Cluster Configuration

# Storage pool
resource "lxd_storage_pool" "xs_storage_pool" {
  name   = "${var.xs_label}-pool"
  driver = "dir"
  config = {
    source = "${path.cwd}/.lxd-pools/${var.xs_label}-pool"
  }
}

# Network
resource "lxd_network" "xs_network" {
  name = var.xs_network.name

  config = {
    "ipv4.address" = var.xs_network.ipv4.address
    "ipv4.nat"     = "true"
    "ipv6.address" = "none"
  }
}

# Profile
resource "lxd_profile" "xs_profiles" {
  depends_on = [
    lxd_storage_pool.xs_storage_pool
  ]

  for_each = {
    for index, profile in var.xs_profiles :
    profile.name => profile.limits
  }

  name = each.key

  config = {
    "boot.autostart" = false
    "limits.cpu"     = each.value.cpu
    "limits.memory"  = each.value.memory
  }

  device {
    type = "disk"
    name = "root"

    properties = {
      pool = "${var.xs_label}-pool"
      path = "/"
    }
  }
}

# Containers
resource "lxd_instance" "xs_instances" {
  depends_on = [
    lxd_network.xs_network,
    lxd_profile.xs_profiles
  ]

  for_each = {
    for index, container in var.xs_instances :
    container.name => container
  }

  name  = "${var.xs_label}-${each.key}"
  image = var.xs_image
  profiles = [
    each.value.profile
  ]

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = lxd_network.xs_network.name
      "ipv4.address" = "${each.value.ip}"
    }
  }

  file {
    source_path = try(var.xs_ssh_authorized_pubkey_path, "")
    target_path = "/root/.ssh/authorized_keys"
  }
}
