# Create the public ip for Azure Bastion
resource "azurerm_public_ip" "bastion_pip" {
  count               = var.bastion != null ? 1 : 0
  name                = var.bastion.ip_configuration.name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.bastion.ip_configuration.allocation_method
  sku                 = var.bastion.ip_configuration.sku
  tags                = var.tags
}

# Create the Azure Bastion
resource "azurerm_bastion_host" "bastion" {
  count               = var.bastion != null ? 1 : 0
  name                = var.bastion.name
  resource_group_name = var.resource_group_name
  location            = var.location
  scale_units         = var.bastion.scale_units

  ip_configuration {
    name                 = "ip-configuration"
    subnet_id            = azurerm_subnet.bastion_subnet[0].id
    public_ip_address_id = azurerm_public_ip.bastion_pip[0].id
  }

  tags = var.tags
}
