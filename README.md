# Azure Landing Zone Hub

This module provisions a **hub vnet** in an Azure Landing Zone.

It is intented to be used in conjonction with the **lz-spoke module** which can be found here : https://registry.terraform.io/modules/ldesmons-telstra/lz-spoke/azurerm/latest

## Features 

- creates a **hub vnet** with optional capabilities like firewall, bastion... 
- creates a **vnet gateway**, a **local network gateway** and a **gateway connection**
- *optional* : creates a **firewall**
- *optional* : create a **bastion**

## Usage

**Create a hub vnet with the vnet gateway only**

```terraform
resource "azurerm_resource_group" "rg_hub" {
  name     = "my-rg"
  location = "southeastasia"
  tags     = {
    "environment" : "dev"
  }
}

module "vnet_hub" {
  source              = "ldesmons-telstra/lz-hub/azurerm"
  version             = "1.0.0"
  location            = "southeastasia"
  resource_group_name = "my-rg"
  name                = "vnet-spoke"
  address_space       = ["10.0.0.0/24"]
  subnets = [
    {
      address_prefixes = ["10.0.0.0/26"]
      name             = "subnet-01"
    },
    {
      address_prefixes = ["10.0.0.1/26"]
      name             = "subnet-02"
    }
  ]
  tags = {
    "environment" : "dev"
  }
}
```
