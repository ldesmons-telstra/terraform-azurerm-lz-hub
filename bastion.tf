/* -----------------------
   Locals.
   -----------------------
*/

locals {
  bastion_count = var.provision_bastion ? 1 : 0
}

/* -----------------------
   Create bastion (optional).
   -----------------------
*/

# public IP
resource "azurerm_public_ip" "bastion_pip" {
  count               = local.bastion_count
  name                = var.bastion_public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.bastion_public_ip_allocation_method
  sku                 = var.bastion_public_ip_sku
  tags                = var.tags
}

# bastion
resource "azurerm_bastion_host" "bastion" {
  count               = local.bastion_count
  name                = var.bastion_name
  resource_group_name = var.resource_group_name
  location            = var.location
  scale_units         = var.bastion_scale_units

  ip_configuration {
    name                 = "ip-configuration"
    subnet_id            = azurerm_subnet.bastion_subnet[0].id
    public_ip_address_id = azurerm_public_ip.bastion_pip[0].id
  }

  tags = var.tags
}
