data "azurerm_subnet" "this" {
  for_each             = var.bastion_details
  name                 = each.value.subnetname
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_public_ip" "this" {
  for_each            = var.bastion_details
  name                = each.value.pipname
  resource_group_name = each.value.resource_group_name
}
resource "azurerm_bastion_host" "this" {
  for_each            = var.bastion_details
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.ipname
    subnet_id            = data.azurerm_subnet.this[each.key].id
    public_ip_address_id = data.azurerm_public_ip.this[each.key].id
  }
}