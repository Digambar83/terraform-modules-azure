resource "azurerm_network_security_group" "this" {
  for_each            = var.nsg_details
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  dynamic "security_rule" {
    for_each = each.value.security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}