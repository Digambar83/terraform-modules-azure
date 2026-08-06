data "azurerm_subnet" "this" {
  for_each             = var.nsg_association_details
  name                 = each.value.subnetname
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_network_security_group" "this" {
  for_each            = var.nsg_association_details
  name                = each.value.nsgname
  resource_group_name = each.value.resource_group_name
}
resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = var.nsg_association_details
  network_security_group_id = data.azurerm_network_security_group.this[each.key].id
  subnet_id                 = data.azurerm_subnet.this[each.key].id
}