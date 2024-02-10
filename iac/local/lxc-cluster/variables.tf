variable "xs_label" {
  type = string
}

variable "xs_image" {
  type = string
}

variable "xs_network" {
  type = object({
    name = string
    ipv4 = object({
      address = string
    })
  })
}

variable "xs_profiles" {
  type = list(object({
    name = string
    limits = object({
      cpu    = number
      memory = string
    })
  }))
}

variable "xs_containers" {
  type = list(object({
    name    = string
    profile = string
    ip      = string
  }))
}