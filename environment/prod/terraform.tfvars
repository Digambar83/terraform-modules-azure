rgs = {
  rg1 = {
    name       = "dev"
    location   = "centralindia"
    managed_by = "terraform"
  }
}
virtual_network_details = {
  vnet1 = {
    name                = "devvnet1"
    location            = "centralindia"
    resource_group_name = "dev"
    address_space       = ["10.23.0.0/16"]
  }
}
subnets = {
  subnet1 = {
    resource_group_name  = "dev"
    virtual_network_name = "devvnet1"
    address_prefixes     = ["10.23.1.0/24"]
    name                 = "frontendsubnet"
  }
  subnet2 = {
    resource_group_name  = "dev"
    virtual_network_name = "devvnet1"
    address_prefixes     = ["10.23.2.0/24"]
    name                 = "backendsubnet"
  }
  subnet3 = {
    resource_group_name  = "dev"
    virtual_network_name = "devvnet1"
    address_prefixes     = ["10.23.3.0/24"]
    name                 = "AzureBastionSubnet"
  }
}
pip_details = {
  pip1 = {
    name                = "bastionpip1"
    resource_group_name = "dev"
    location            = "centralindia"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}
bastion_details = {
  bastion = {
    name                 = "bastion1"
    resource_group_name  = "dev"
    location             = "centralindia"
    subnetname           = "AzureBastionSubnet"
    pipname              = "bastionpip1"
    virtual_network_name = "devvnet1"
    ipname               = "configurtion"

  }
}
nsg_details = {
  nsg1 = {
    name                = "nsg1"
    location            = "centralindia"
    resource_group_name = "dev"
    security_rules = [
      {
        name                   = "http"
        priority               = 100
        destination_port_range = "80"
      },
      {
        name                   = "ssh"
        priority               = 101
        destination_port_range = "22"
      }
    ]
  }
  nsg2 = {
    name                = "nsg2"
    location            = "centralindia"
    resource_group_name = "dev"
    security_rules = [
      {
        name                   = "http"
        priority               = 100
        destination_port_range = "80"
      },
      {
        name                   = "ssh"
        priority               = 101
        destination_port_range = "22"
      }
    ]
  }
}
nsg_association_details = {
  association1 = {
    nsgname              = "nsg1"
    virtual_network_name = "devvnet1"
    resource_group_name  = "dev"
    subnetname           = "frontendsubnet"

  }
  association2 = {
    nsgname              = "nsg2"
    virtual_network_name = "devvnet1"
    resource_group_name  = "dev"
    subnetname           = "backendsubnet"

  }
}
vms_details = {
  vm1 = {
    nic_name                      = "nsg1"
    location                      = "centralindia"
    resource_group_name           = "dev"
    ipname                        = "internal"
    private_ip_address_allocation = "Dynamic"
    datasubnetname                = "frontendsubnet"
    virtual_network_name          = "devvnet1"
    name                          = "frontendvm-new"
    size                          = "Standard_B2as_v2"
    admin_username                = "adminuser"
    admin_password                = "Password@12345"
    caching                       = "ReadWrite"
    storage_account_type          = "Standard_LRS"
    publisher                     = "Canonical"
    offer                         = "0001-com-ubuntu-server-jammy"
    sku                           = "22_04-lts"
    version                       = "latest"

  }
  vm2 = {
    nic_name                      = "nsg2"
    location                      = "centralindia"
    resource_group_name           = "dev"
    ipname                        = "internal"
    private_ip_address_allocation = "Dynamic"
    datasubnetname                = "backendsubnet"
    virtual_network_name          = "devvnet1"
    name                          = "backendvm-new"
    size                          = "Standard_B2as_v2"
    admin_username                = "adminuser"
    admin_password                = "Password@12345"
    caching                       = "ReadWrite"
    storage_account_type          = "Standard_LRS"
    publisher                     = "Canonical"
    offer                         = "0001-com-ubuntu-server-jammy"
    sku                           = "22_04-lts"
    version                       = "latest"
  }
}
