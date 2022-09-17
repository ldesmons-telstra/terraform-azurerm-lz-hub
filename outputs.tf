# output variables
output "vnet_id" {
    value = azurerm_virtual_network.vnet.id
    description = "The id of the hub VNET after it is created."
}

