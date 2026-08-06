data "azurerm_subnet" "subnet" {
  for_each             = var.vms_details
  name                 = each.value.datasubnetname
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_network_interface" "vms" {
  for_each            = var.vms_details
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  ip_configuration {
    name                          = each.value.ipname
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }

}
resource "azurerm_linux_virtual_machine" "vm_details" {
  for_each                        = var.vms_details
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  network_interface_ids           = [azurerm_network_interface.vms[each.key].id, ]
  admin_password                  = each.value.admin_password
  disable_password_authentication = false


  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}
