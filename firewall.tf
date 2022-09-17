# Create the public ip for Azure Firewall
resource "azurerm_public_ip" "firewall_pip" {
  count               = var.firewall != null ? 1 : 0
  name                = var.firewall.ip_configuration.name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.firewall.ip_configuration.allocation_method
  sku                 = var.firewall.ip_configuration.sku
  tags                = var.tags
}

# Create the Azure Firewall
resource "azurerm_firewall" "firewall" {
  count               = var.firewall != null ? 1 : 0
  name                = var.firewall.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.firewall.sku_name
  sku_tier            = var.firewall.sku_tier

  ip_configuration {
    name                 = "ip-configuration"
    subnet_id            = azurerm_subnet.firewall_subnet[0].id
    public_ip_address_id = azurerm_public_ip.firewall_pip[0].id
  }

  tags = var.tags
}