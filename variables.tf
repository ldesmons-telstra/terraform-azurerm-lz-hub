# general 
variable "location" {
  type        = string
  description = "The location where the resources are going to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the existing resource group."
}

# vnet gateway
variable "name" {
  type        = string
  description = "The name of the vnet."
}

variable "address_space" {
  type        = list(string)
  description = "The address space of the VNET."
}

# 
# vnet gateway variables
variable "vnet_gateway_name" {
  type        = string
  description = "The name of the vnet gateway."
}

variable "vnet_gateway_type" {
  type        = string
  default     = "Vpn"
  description = "(Optional) The type of the vnet gateway."
}

variable "vnet_gateway_vpn_type" {
  type        = string
  default     = "RouteBased"
  description = "(Optional) The vpn type of the vnet gateway."
}

variable "vnet_gateway_sku" {
  type        = string
  default     = "VpnGw1"
  description = "(Optional) The sku of the vnet gateway."
}

variable "vnet_gateway_generation" {
  type        = string
  default     = "Generation1"
  description = "(Optional) The generation of the vnet gateway."
}

variable "vnet_gateway_configure_bgp" {
  type        = bool
  default     = false
  description = "(Optional) Whether to configure the BGP of the vnet gateway."
}

variable "vnet_gateway_active_active" {
  type        = bool
  default     = false
  description = "(Optional) Whether the vnet gateway is active-active."
}

variable "vnet_gateway_address_prefixes" {
  type        = list(string)
  description = "The address prefixes of the vnet gateway."
}

variable "vnet_gateway_public_ip_name" {
  type        = string
  description = "The name of the public ip of the vnet gateway."
}

variable "vnet_gateway_public_ip_allocation_method" {
  type        = string
  default     = "Static"
  description = "(Optional) The allocation method of the public ip of the vnet gateway."
}

variable "vnet_gateway_public_ip_sku" {
  type        = string
  default     = "Standard"
  description = "(Optional) The sku of the public ip of the vnet gateway."
}

# local network gateway
variable "local_network_gateway_name" {
  type        = string
  description = "The name of the local network gateway."
}

variable "local_network_gateway_address" {
  type        = string
  description = "The address of the local network gateway."
}

variable "local_network_gateway_address_space" {
  type        = list(string)
  description = "The address space of the local network gateway."
}

# gateway connection
variable "gateway_connection_name" {
  type        = string
  description = "The name of the gateway connection."
}

variable "gateway_connection_type" {
  type        = string
  default     = "IPsec"
  description = "The type of the gateway connection."
}

variable "gateway_connection_shared_key" {
  type        = string
  sensitive   = true
  description = "The shared key of the gateway connection."
}

# firewall (optional)
variable "provision_firewall" {
  type        = bool
  default     = true
  description = "(Optional) The firewall will be provisioned only if this value is set to true (default)."
}

variable "firewall_name" {
  type        = string
  default     = ""
  description = "(Optional) The name of the firewall. Mandatory if provision_firewall is set to true."
}

variable "firewall_sku_name" {
  type        = string
  default     = "AZFW_VNet"
  description = "(Optional) The sku name of the firewall."
}

variable "firewall_sku_tier" {
  type        = string
  default     = "Standard"
  description = "(Optional) The sku tier of the firewall."
}

variable "firewall_subnet_address_prefixes" {
  type        = list(string)
  default     = []
  description = "(Optional) The address prefixes of the firewall. Mandatory if provision_firewall is set to true."
}

variable "firewall_public_ip_name" {
  type        = string
  default     = ""
  description = "(Optional) The name of the public ip of the firewall. Mandatory if provision_firewall is set to true."
}

variable "firewall_public_ip_allocation_method" {
  type        = string
  default     = "Static"
  description = "(Optional) The allocation method of the public ip of the firewall."
}

variable "firewall_public_ip_sku" {
  type        = string
  default     = "Standard"
  description = "(Optional) The sku of the public ip of the firewall."
}

# bastion (optional)
variable "provision_bastion" {
  type        = bool
  default     = true
  description = "(Optional) The bastion will be provisioned only if this value is set to true (default)."
}

variable "bastion_name" {
  type        = string
  default     = ""
  description = "(Optional) The name of the bastion. Mandatory if provision_bastion is set to true."
}

variable "bastion_scale_units" {
  type        = number
  default     = 2
  description = "(Optional) The scale units of the bastion."
}

variable "bastion_subnet_address_prefixes" {
  type        = list(string)
  default     = []
  description = "(Optional) The address prefixes of the bastion. Mandatory if provision_bastion is set to true."
}

variable "bastion_public_ip_name" {
  type        = string
  default     = ""
  description = "(Optional) The name of the public ip of the bastion. Mandatory if provision_bastion is set to true."
}

variable "bastion_public_ip_allocation_method" {
  type        = string
  default     = "Static"
  description = "(Optional) The allocation method of the public ip of the bastion."
}

variable "bastion_public_ip_sku" {
  type        = string
  default     = "Standard"
  description = "(Optional) The sku of the public ip of the bastion."
}

# tags (optional)
variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) The tags to apply to all resources."
}