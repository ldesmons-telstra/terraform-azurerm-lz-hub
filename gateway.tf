# Public IP for the VPN Gateway
resource "azurerm_public_ip" "vnet_gateway_pip" {
  name                = var.vnet_gateway_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.vnet_gateway_public_ip_allocation_method
  sku                 = var.vnet_gateway_public_ip_sku
  tags                = var.tags
}

# Virtual Network Gateway
resource "azurerm_virtual_network_gateway" "vnet_gateway" {
  name                = var.vnet_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = var.vnet_gateway_type
  vpn_type            = var.vnet_gateway_vpn_type
  active_active       = var.vnet_gateway_active_active
  enable_bgp          = var.vnet_gateway_configure_bgp
  sku                 = var.vnet_gateway_sku
  generation          = var.vnet_gateway_generation

  ip_configuration {
    name                 = "vnetGatewayConfig"
    public_ip_address_id = azurerm_public_ip.vnet_gateway_pip.id
    subnet_id            = azurerm_subnet.gateway_subnet.id
  }

  tags = var.tags
}

# Local Network Gateway
resource "azurerm_local_network_gateway" "local_gateway" {
  name                = var.local_network_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  gateway_address     = var.local_network_gateway_address
  address_space       = var.local_network_gateway_address_space
  tags                = var.tags
}

# Connection 
resource "azurerm_virtual_network_gateway_connection" "gateway_connection" {
  name                       = var.gateway_connection_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  type                       = var.gateway_connection_type
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vnet_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gateway.id
  shared_key                 = var.gateway_connection_shared_key
  tags                       = var.tags
}