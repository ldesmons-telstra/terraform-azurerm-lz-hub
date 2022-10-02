/* -----------------------
   Output variables.
   -----------------------
*/

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The id of the newly created hub vnet."
}

output "gateway_subnet_id" {
  value       = azurerm_subnet.gateway_subnet.id
  description = "The id of the gateway subnet."
}

output "firewall_private_ip_address" {
  value       = var.provision_firewall ? azurerm_firewall.firewall[0].ip_configuration[0].private_ip_address : ""
  description = "The private ip of the firewall. Empty if the firewall was not provisioned."
}
