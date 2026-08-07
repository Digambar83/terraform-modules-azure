rgs = {
  rg1 = {
    name       = "dev"
    location   = "centralindia"
    managed_by = "terraform"
  }
  rg2 = {
    name       = "pre-prod"
    location   = "centralindia"
    managed_by = "terraform"
  }
  rg3 = {
    name       = "pre-prod1"
    location   = "centralindia"
    managed_by = "terraform"
  }
  rg6 = {
    name       = "pre-prod13"
    location   = "centralindia"
    managed_by = "terraform"
  }
  # test change
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
   subnet4 = {
    resource_group_name  = "dev"
    virtual_network_name = "devvnet1"
    address_prefixes     = ["10.23.3.0/24"]
    name                 = "loadbalancersubnet"
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
  pip1 = {
    name                = "pip-appgw-dev"
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
    caching                       = "ReadWrite"
    storage_account_type          = "Standard_LRS"
    publisher                     = "Canonical"
    offer                         = "0001-com-ubuntu-server-jammy"
    sku                           = "22_04-lts"
    version                       = "latest"
    key_vault_name                = "pre-prod_kv"
    secret_name                   = "admin-password"
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
    caching                       = "ReadWrite"
    storage_account_type          = "Standard_LRS"
    publisher                     = "Canonical"
    offer                         = "0001-com-ubuntu-server-jammy"
    sku                           = "22_04-lts"
    version                       = "latest"
    key_vault_name                = "pre-prod_kv"
    secret_name                   = "admin-password"
  }
}
key_vault = {
  kv1 = {
    name                = "pre-prod-kv"
    location            = "centralindia"
    resource_group_name = "dev"
    secret_name         = "admin-password"
  }
}
load_balancers = {
  lb1 = {
    name        = "lb-backend-dev"
    location    = "centralindia"
    rg_name     = "dev"
    subnet_name = "loadbalancersubnet"
    vnet_name   = "devnet1"
  }
}
app_gateways = {
  appgw1 = {
    name           = "appgw-dev"
    location       = "centralindia"
    rg_name        = "dev"
    subnet_name    = "AppGatewaySubnet"
    vnet_name      = "devvnet1"
    public_ip_name = "pip-appgw-dev"
  }
}