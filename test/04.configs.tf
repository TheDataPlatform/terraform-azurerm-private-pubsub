data "azurerm_client_config" "current" {} # data.azurerm_client_config.current.tenant_id
variable "email_address" {}

locals {
  spoke_rg_name   = "sandbox-rg"
  hub_rg_name     = "hub-rg"
  spoke_vnet_name = "sandbox-vnet"
  hub_vnet_name   = "hub-vnet"
}