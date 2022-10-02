/* -----------------------
   Locals.
   -----------------------
*/

locals {
  firewall_count = var.provision_firewall ? 1 : 0
}

/* -----------------------
   Create the firewall (optional).
   -----------------------
*/

# public IP
resource "azurerm_public_ip" "firewall_pip" {
  count               = local.firewall_count
  name                = var.firewall_public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.firewall_public_ip_allocation_method
  sku                 = var.firewall_public_ip_sku
  tags                = var.tags
}

# firewall
resource "azurerm_firewall" "firewall" {
  count               = local.firewall_count
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.firewall_sku_name
  sku_tier            = var.firewall_sku_tier

  ip_configuration {
    name                 = "ip-configuration"
    subnet_id            = azurerm_subnet.firewall_subnet[0].id
    public_ip_address_id = azurerm_public_ip.firewall_pip[0].id
  }

  tags = var.tags
}