# Public IP for the VPN Gateway
resource "azurerm_public_ip" "vnet-gateway-pip" {
  name                = var.gateway.ip_configuration.name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.gateway.ip_configuration.allocation_method
  sku                 = var.gateway.ip_configuration.sku
  tags                = var.tags
}

# Virtual Network Gateway
resource "azurerm_virtual_network_gateway" "vnet-gateway" {
  name                = var.gateway.name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = var.gateway.gateway_type
  vpn_type            = var.gateway.vpn_type
  active_active       = var.gateway.active_active
  enable_bgp          = var.gateway.configure_bgp
  sku                 = var.gateway.sku
  generation          = var.gateway.generation

  ip_configuration {
    name                 = "vnetGatewayConfig"
    public_ip_address_id = azurerm_public_ip.vnet-gateway-pip.id
    subnet_id            = azurerm_subnet.gateway_subnet.id
  }

  tags = var.tags
}

# Local Network Gateway
resource "azurerm_local_network_gateway" "local-gateway" {
  name                = var.gateway.lng_configuration.name
  resource_group_name = var.resource_group_name
  location            = var.location
  gateway_address     = var.gateway.lng_configuration.gateway_address
  address_space       = var.gateway.lng_configuration.address_space
  tags                = var.tags
}

# Connection 
resource "azurerm_virtual_network_gateway_connection" "gateway-connection" {
  name                       = var.gateway.connection_configuration.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  type                       = var.gateway.connection_configuration.connection_type
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vnet-gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local-gateway.id
  shared_key                 = var.gateway.connection_configuration.shared_key
  tags                       = var.tags
}