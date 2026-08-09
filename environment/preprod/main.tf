module "rg_details" {
  source = "../../child module/azurerm_resource_group"
  rgs    = var.rgs
}
module "virtual_network" {
  depends_on              = [module.rg_details]
  source                  = "../../child module/azurerm_virtual_network"
  virtual_network_details = var.virtual_network_details
}
module "subnets" {
  depends_on = [module.virtual_network]
  source     = "../../child module/azurerm_subnet"
  subnets    = var.subnets
}
module "pip_details" {
  depends_on  = [module.rg_details]
  source      = "../../child module/azurerm_public_IP"
  pip_details = var.pip_details

}
module "nsg_details" {
  depends_on  = [module.subnets, module.rg_details]
  source      = "../../child module/azurerm_network_security_group"
  nsg_details = var.nsg_details
}
module "network_association" {
  depends_on              = [module.nsg_details, module.subnets]
  source                  = "../../child module/azurerm_subnet_network_security_group_association"
  nsg_association_details = var.nsg_association_details
}
module "key_vault" {
  depends_on = [module.rg_details]
  source     = "../../child module/azurerm_key_vault"
  key_vault  = var.key_vault
}
module "vms" {
  depends_on  = [module.nsg_details, module.virtual_network, module.rg_details, module.key_vault]
  source      = "../../child module/azurerm_virtual_machine"
  vms_details = var.vms_details

}
module "loadbalancer" {
  depends_on = [ module.subnets,module.vms ]
  source = "../../child module/azurerm_lb"
  load_balancers = var.load_balancers
}
module "gateway" {
  depends_on = [ module.pip_details,module.vms ]
  source = "../../child module/azurerm_application_gateway"
  app_gateways = var.app_gateways
}