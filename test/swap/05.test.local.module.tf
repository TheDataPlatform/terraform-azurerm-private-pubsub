module "private-pubsub" {
  source                                  = "../"
  providers = {
    azurerm.hub                           = azurerm.hub
    azurerm.spoke                         = azurerm.spoke
  }
  tenant_id                               = data.azurerm_client_config.current.tenant_id
  principal_id                            = data.azurerm_client_config.current.object_id # for key vault management
  resource_group_name                     = local.spoke_rg_name
  resource_group_name_hub                 = local.hub_rg_name

  # Storage Account Networking
  whitelist_ip_addresses                  = [ local.current_ip_address ] # list of ip addresses
  allowed_subnets                         = [ data.azurerm_subnet.private-endpoints-subnet.id ] # list of subnet ids
  
  # Using the same private endpoint subnet, but making it easier to manage multiple
  app-service-integration-subnet          = data.azurerm_subnet.subnet-app-service-integration.id
  keyvault-subnet                         = data.azurerm_subnet.private-endpoints-subnet.id 
  storage-subnet                          = data.azurerm_subnet.private-endpoints-subnet.id 
  application-subnet                      = data.azurerm_subnet.private-endpoints-subnet.id 
  servicebus-subnet                       = data.azurerm_subnet.private-endpoints-subnet.id
  database-subnet                         = data.azurerm_subnet.private-endpoints-subnet.id

  azurerm_user_assigned_identity_name     = "uaid${random_string.this.result}"
  azurerm_storage_account_name            = "storageaccount${random_string.this.result}"
  azurerm_key_vault_name                  = "keyvault${random_string.this.result}"
  azurerm_service_plan_name               = "function-plan-${random_string.this.result}"
  azurerm_windows_function_app_name       = "function-app-${random_string.this.result}"
  azurerm_log_analytics_workspace_name    = "log-workspace-${random_string.this.result}"
  azurerm_application_insights_name       = "app-insights-${random_string.this.result}"
  azurerm_servicebus_namespace_name       = "service-bus-${random_string.this.result}"
  azurerm_servicebus_queue_name           = "service-bus-queue"
  azurerm_mssql_server_name               = "sqlserver-${random_string.this.result}"
  azurerm_mssql_database_name             = "database-${random_string.this.result}"

  sql_server_admin_name                   = "andrew"
  azuread_administrator_login_username    = var.email_address
  azuread_administrator_object_id         = data.azurerm_client_config.current.object_id

# hub resources
  azurerm_private_dns_zone_blob           = data.azurerm_private_dns_zone.blob.id   #azurerm_private_dns_zone.hub["blob"].id
  azurerm_private_dns_zone_queue          = data.azurerm_private_dns_zone.queue.id  #azurerm_private_dns_zone.hub["queue"].id
  azurerm_private_dns_zone_table          = data.azurerm_private_dns_zone.table.id  #azurerm_private_dns_zone.hub["table"].id
  azurerm_private_dns_zone_file           = data.azurerm_private_dns_zone.file.id   #azurerm_private_dns_zone.hub["file"].id
  azurerm_private_dns_zone_azurewebsites  = data.azurerm_private_dns_zone.azurewebsites.id
  azurerm_private_dns_zone_servicebus     = data.azurerm_private_dns_zone.servicebus.id
}