resource "azurerm_user_assigned_identity" "this" {
  name                = local.azurerm_user_assigned_identity_name
  resource_group_name = local.resource_group_name
  location            = local.location
  provider            = azurerm.spoke
}