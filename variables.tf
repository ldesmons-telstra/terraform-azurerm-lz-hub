# general variables
variable "location" {
  type        = string
  description = "Location where the resources are going to be created."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

# VNET variables
variable "name" {
  type        = string
  description = "Name of the VNET."
}

variable "address_space" {
  type        = list(string)
  description = "Address space of the VNET."
}

# VNET gateway variables
variable "gateway" {
  type = object({
    name                    = string,
    gateway_type            = string,
    vpn_type                = string,
    sku                     = string,
    generation              = string,
    configure_bgp           = bool,
    active_active           = bool,
    subnet_address_prefixes = list(string)

    ip_configuration = object({
      name              = string,
      allocation_method = string,
      sku               = string
    })

    lng_configuration = object({
      name            = string,
      gateway_address = string,
      address_space   = list(string)
    })

    connection_configuration = object({
      name            = string,
      connection_type = string,
      shared_key      = string
    })

  })

  description = <<-EOT
    The input values for the VNET Gateway.

    name : the name of the gateway.
    gateway_type : the type of the gateway.
    vpn_type = the type of the VPN.

  EOT
}

# firewall variables
variable "firewall" {
  type = object({
    name                    = string,
    sku_name                = string,
    sku_tier                = string,
    subnet_address_prefixes = list(string)

    ip_configuration = object({
      name              = string,
      allocation_method = string,
      sku               = string
    })
  })

  default     = null 
  description = <<-EOT
    The input values for the Firewall.

    name : the name of the firewall.
    sku_name : the name of the SKU to use for the firewall.
    sku_tier : the SKU tier to use for the firewall.
    subnet_address_prefixes : list of address prefixes for the firewall.
    
    ip_configuration : the public IP configuration of the firewall.
      name : the name of the public IP.
      allocation_method : the allocation method of the public IP.
      sku : the sku of the public IP
  EOT
}

# bastion variables
variable "bastion" {
  type = object({
    name                    = string,
    scale_units             = number,
    subnet_address_prefixes = list(string)

    ip_configuration = object({
      name              = string,
      allocation_method = string,
      sku               = string
    })
  })

  default     = null # optional
 description = <<-EOT
    The input values for the Bastion.

    name : the name of the bastion.
    scale_units : the scale units of the bastion.
    subnet_address_prefixes : list of address prefixes for the bastion.
    
    ip_configuration : the public IP configuration of the bastion.
      name : the name of the public IP.
      allocation_method : the allocation method of the public IP.
      sku : the sku of the public IP
  EOT
}

# tags
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources."
}