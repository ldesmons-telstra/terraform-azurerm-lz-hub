# Azure Landing Zone Hub

This module provisions a **hub vnet** in an Azure Landing Zone.

It is intented to be used in conjonction with the **lz-spoke module** which can be found here : https://registry.terraform.io/modules/ldesmons-telstra/lz-spoke/azurerm/latest

## Features 

- creates a **hub vnet** with optional capabilities like firewall, bastion... 
- creates a **vnet gateway**, a **local network gateway** and a **gateway connection**
- *optional* : creates a **firewall**
- *optional* : create a **bastion**

## Usage

**Create a hub vnet with the vnet gateway only, wihout firewall or bastion**

```terraform
resource "azurerm_resource_group" "rg_hub" {
  name     = "my-rg"
  location = "southeastasia"
  tags     = {
    "environment" : "dev"
  }
}

module "vnet_hub" {
  source  = "ldesmons-telstra/lz-hub/azurerm"
  version = "1.0.0"

  location            = "southeastasia"
  resource_group_name = "my-rg"
  name                = "my-vnet-hub"
  address_space       = ["10.10.31.0/24"]

  vnet_gateway_name                   = "my-vnet-gateway"
  vnet_gateway_address_prefixes       = ["10.10.31.128/27"]
  vnet_gateway_public_ip_name         = "my-vnet-gateway-pip"
  local_network_gateway_name          = "my-local-network-gateway"
  local_network_gateway_address       = "203.134.151.51"
  local_network_gateway_address_space = ["192.1.1.0/24", "192.168.0.0/24", "192.168.1.0/24", "192.2.2.0/24"]
  gateway_connection_name             = "my-local-network-gateway-connection"
  gateway_connection_shared_key       = "shared-key"

  provision_firewall                  = false   # do not create firewall
  provision_bastion                   = false   # do not create bastion

  tags                                = var.tags
}
```

**Create a hub vnet with the vnet gateway and a firewall**

```terraform
resource "azurerm_resource_group" "rg_hub" {
  name     = "my-rg"
  location = "southeastasia"
  tags     = {
    "environment" : "dev"
  }
}

module "vnet_hub" {
  source  = "ldesmons-telstra/lz-hub/azurerm"
  version = "1.0.0"

  location            = "southeastasia"
  resource_group_name = "my-rg"
  name                = "my-vnet-hub"
  address_space       = ["10.10.31.0/24"]

  vnet_gateway_name                   = "my-vnet-gateway"
  vnet_gateway_address_prefixes       = ["10.10.31.128/27"]
  vnet_gateway_public_ip_name         = "my-vnet-gateway-pip"
  local_network_gateway_name          = "my-local-network-gateway"
  local_network_gateway_address       = "203.134.151.51"
  local_network_gateway_address_space = ["192.1.1.0/24", "192.168.0.0/24", "192.168.1.0/24", "192.2.2.0/24"]
  gateway_connection_name             = "my-local-network-gateway-connection"
  gateway_connection_shared_key       = "shared-key"

  firewall_name                       = "my-firewall"
  firewall_public_ip_name             = "my-firewall-pip"
  firewall_subnet_address_prefixes    = ["10.10.31.0/26"]

  provision_bastion                   = false   # do not create bastion

  tags                                = var.tags
}
```

**Create a hub vnet with the vnet gateway, a firewall and a bastion**

```terraform
resource "azurerm_resource_group" "rg_hub" {
  name     = "my-rg"
  location = "southeastasia"
  tags     = {
    "environment" : "dev"
  }
}

module "vnet_hub" {
  source  = "ldesmons-telstra/lz-hub/azurerm"
  version = "1.0.0"

  location            = "southeastasia"
  resource_group_name = "my-rg"
  name                = "my-vnet-hub"
  address_space       = ["10.10.31.0/24"]

  vnet_gateway_name                   = "my-vnet-gateway"
  vnet_gateway_address_prefixes       = ["10.10.31.128/27"]
  vnet_gateway_public_ip_name         = "my-vnet-gateway-pip"
  local_network_gateway_name          = "my-local-network-gateway"
  local_network_gateway_address       = "203.134.151.51"
  local_network_gateway_address_space = ["192.1.1.0/24", "192.168.0.0/24", "192.168.1.0/24", "192.2.2.0/24"]
  gateway_connection_name             = "my-local-network-gateway-connection"
  gateway_connection_shared_key       = "shared-key"

  firewall_name                       = "my-firewall"
  firewall_public_ip_name             = "my-firewall-pip"
  firewall_subnet_address_prefixes    = ["10.10.31.0/26"]

  bastion_name                        = "my-bastion"
  bastion_public_ip_name              = "my-bastion-pip"
  bastion_subnet_address_prefixes     = ["10.10.31.64/26"]

  tags                                = var.tags
}
```