resource "azurerm_service_plan" "this" {
  provider                  = azurerm.spoke
  name                      = local.azurerm_service_plan_name
  resource_group_name       = local.resource_group_name
  location                  = local.location
  os_type                   = "Windows"
  sku_name                  = "EP1"    
}

# Note: You will want to deploy application code into the function for the splash screen to work properly and complete the process.
resource "azurerm_windows_function_app" "this" {
  provider                        = azurerm.spoke
  name                            = local.azurerm_windows_function_app_name
  resource_group_name             = local.resource_group_name
  location                        = local.location
  service_plan_id                 = azurerm_service_plan.this.id
  storage_key_vault_secret_id     = azurerm_key_vault_secret.storage-connection-string.id # secret containing connection string  
  key_vault_reference_identity_id = azurerm_user_assigned_identity.this.id  # identity with access to keyvault
  https_only                      = true
  public_network_access_enabled   = false
  virtual_network_subnet_id       = local.app-service-integration-subnet
  

  identity {
    type                          = "UserAssigned"
    identity_ids                  =  [ azurerm_user_assigned_identity.this.id ]
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY              = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.app-insights-instrumentation-key.id})" # ... app insights instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.app-insights-connection-string.id})" #... app insights connection_string

    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING    = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.storage-connection-string.id})"
    WEBSITE_CONTENTOVERVNET                     = "1"
    WEBSITE_CONTENTSHARE                        = local.azurerm_windows_function_app_name
    
    #WEBSITE_LOAD_CERTIFICATES = "*" # maybe skip
    WEBSITE_RUN_FROM_PACKAGE                    = "1"
    FUNCTIONS_WORKER_RUNTIME                    = "dotnet-isolated"
    FUNCTIONS_EXTENSION_VERSION                 = "~4"
    
    AzureWebJobsStorage                         = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.storage-connection-string.id})"
    WEBSITE_SKIP_CONTENTSHARE_VALIDATION        = 1 # might drop this
  }

  site_config {
    application_stack {
        dotnet_version            = "v8.0"
    }
    use_32_bit_worker             = false
    always_on                     = true
    vnet_route_all_enabled        = true
    
    application_insights_connection_string = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.app-insights-connection-string.id})"
    application_insights_key               = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.app-insights-instrumentation-key.id})"
  }

  depends_on = [ azurerm_storage_share.function ]
}