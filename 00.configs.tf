terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      configuration_aliases = [
        azurerm.hub,
        azurerm.spoke
      ]
    }
  }
}

# ----------------------- Variables -------------------------

variable "location" {
  description = "default location"
  type        = string
  default     = "East US 2"
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "azurerm_user_assigned_identity_name" {

}

variable "azurerm_storage_account_name" {

}

variable "azurerm_key_vault_name" {

}

variable "tenant_id" {

}

variable "azurerm_service_plan_name" {
  
}

variable "principal_id" {
  
}

variable "azurerm_windows_function_app_name" {
  
}

variable "app-service-integration-subnet" {
  
}

variable "keyvault-subnet" {

}

variable "storage-subnet" {

}

variable "application-subnet" {

}

variable "azurerm_log_analytics_workspace_name" {
  
}

variable "azurerm_application_insights_name" {
  
}

variable "azurerm_servicebus_namespace_name" {
  
}

variable "azurerm_servicebus_queue_name" {
  
}

variable "servicebus-subnet" {

} 

variable "database-subnet" {
  
}

variable "azurerm_mssql_server_name" {

}

variable "azurerm_mssql_database_name" {

}

variable "sql_server_admin_name" {

}

variable "azuread_administrator_login_username" {

}

variable "azuread_administrator_object_id" {

}

variable "resource_group_name_hub" {}

variable "azurerm_private_dns_zone_blob" {}   
variable "azurerm_private_dns_zone_queue" {}     
variable "azurerm_private_dns_zone_table" {}    
variable "azurerm_private_dns_zone_file" {}  
variable "azurerm_private_dns_zone_azurewebsites" {} 
variable "azurerm_private_dns_zone_servicebus" {} 

# ----------------------- Locals -------------------------

locals {
  # High-Level IDs
  tenant_id                               = var.tenant_id  
  principal_id                            = var.principal_id #data.azurerm_client_config.current.object_id 

  # Resource Group Information (Spoke)
  location                                = var.location
  resource_group_name                     = var.resource_group_name

  # Hub Resource Group Name
  resource_group_name_hub                 = var.resource_group_name_hub

  azurerm_user_assigned_identity_name     = var.azurerm_user_assigned_identity_name
  azurerm_storage_account_name            = var.azurerm_storage_account_name
  azurerm_key_vault_name                  = var.azurerm_key_vault_name    
  
  # Function App
  azurerm_service_plan_name               = var.azurerm_service_plan_name    
  azurerm_windows_function_app_name       = var.azurerm_windows_function_app_name    
  
  # Subnets
  app-service-integration-subnet          = var.app-service-integration-subnet
  keyvault-subnet                         = var.keyvault-subnet
  storage-subnet                          = var.storage-subnet
  application-subnet                      = var.application-subnet
  servicebus-subnet                       = var.servicebus-subnet
  database-subnet                         = var.database-subnet

  # Observability
  azurerm_log_analytics_workspace_name    = var.azurerm_log_analytics_workspace_name
  azurerm_application_insights_name       = var.azurerm_application_insights_name

  # Service Bus
  azurerm_servicebus_namespace_name       = var.azurerm_servicebus_namespace_name
  azurerm_servicebus_queue_name           = var.azurerm_servicebus_queue_name

  # SQL Server
  azurerm_mssql_server_name               = var.azurerm_mssql_server_name
  azurerm_mssql_database_name             = var.azurerm_mssql_database_name
  sql_server_admin_name                   = var.sql_server_admin_name
  azuread_administrator_login_username    = var.azuread_administrator_login_username
  azuread_administrator_object_id         = var.azuread_administrator_object_id

  # Private DNS Zones - Pulled from the Hub Subscription
  azurerm_private_dns_zone_blob           = var.azurerm_private_dns_zone_blob
  azurerm_private_dns_zone_queue          = var.azurerm_private_dns_zone_queue
  azurerm_private_dns_zone_table          = var.azurerm_private_dns_zone_table
  azurerm_private_dns_zone_file           = var.azurerm_private_dns_zone_file
  azurerm_private_dns_zone_azurewebsites  = var.azurerm_private_dns_zone_azurewebsites
  azurerm_private_dns_zone_servicebus     = var.azurerm_private_dns_zone_servicebus
}

