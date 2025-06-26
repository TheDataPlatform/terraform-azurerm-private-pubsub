# For monitoring the Function App

resource "azurerm_log_analytics_workspace" "this" {
  provider            = azurerm.spoke
  name                = local.azurerm_log_analytics_workspace_name
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = "PerGB2018"
}



#APPINSIGHTS_INSTRUMENTKEY = "" ... app insights instrumentation_key
#APPLICATIONINSIGHTS_CONNECTION_STRING = "" ... app insights connection_string

resource "azurerm_key_vault_secret" "app-insights-instrumentation-key" {
  provider      = azurerm.spoke
  name          = "${azurerm_application_insights.this.name}-instrumentation-key" #"name" may only contain alphanumeric characters and dashes
  value         = azurerm_application_insights.this.instrumentation_key  
  key_vault_id  = azurerm_key_vault.this.id  
  depends_on    = [ 
    azurerm_application_insights.this,
    azurerm_role_assignment.keyvault_contributor_pipeline
  ]  
}