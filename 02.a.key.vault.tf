# ====================================================
# Key Vault
# ====================================================

resource "azurerm_key_vault" "this" {
  provider                      = azurerm.spoke
  name                          = local.azurerm_key_vault_name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  enabled_for_disk_encryption   = true
  tenant_id                     = local.tenant_id
  soft_delete_retention_days    = 7
  purge_protection_enabled      = false
  sku_name                      = "standard"
  enable_rbac_authorization     = true

}

resource "azurerm_role_assignment" "keyvault_contributor_uaid" {
  provider              = azurerm.spoke
  principal_id          = azurerm_user_assigned_identity.this.principal_id
  role_definition_name  = "Key Vault Secrets Officer"                           
  scope                 = azurerm_key_vault.this.id


}

resource "azurerm_role_assignment" "keyvault_contributor_pipeline" {
  provider              = azurerm.spoke
  principal_id          = local.principal_id #data.azurerm_client_config.current.object_id
  role_definition_name  = "Key Vault Secrets Officer"                           
  scope                 = azurerm_key_vault.this.id
}