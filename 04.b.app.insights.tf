resource "azurerm_application_insights" "this" {
  provider            = azurerm.spoke
  name                = local.azurerm_application_insights_name
  resource_group_name = local.resource_group_name
  location            = local.location
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "web"  
}

resource "azurerm_key_vault_secret" "app-insights-connection-string" {
  provider      = azurerm.spoke
  name          = "${azurerm_application_insights.this.name}-connection-string" #"name" may only contain alphanumeric characters and dashes
  value         = azurerm_application_insights.this.connection_string  
  key_vault_id  = azurerm_key_vault.this.id  
  depends_on    = [ 
    azurerm_application_insights.this,
    azurerm_role_assignment.keyvault_contributor_pipeline
  ]  
}
