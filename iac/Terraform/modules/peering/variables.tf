variable "peerings" {
  description = "Lista de peerings"
  type = list(object({
    name                      = string
    resource_group_name       = string
    virtual_network_name      = string
    remote_virtual_network_id = string
    allow_virtual_network_access = bool
  }))
}
