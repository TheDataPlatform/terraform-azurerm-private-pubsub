variable "whitelist_ip_addresses" {
  type = list(string)
  description = "List of IP addresses to whitelist"
}

variable "allowed_subnets" {
  type = list(string)
  description = "List of allowed subnet ids"
}

resource "azurerm_storage_account" "this" {
  provider                        = azurerm.spoke
  name                            = local.azurerm_storage_account_name
  resource_group_name             = local.resource_group_name
  location                        = local.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  public_network_access_enabled   = true # pair with default action of Deny and subsequent bypass, ip rules, and allowed subnets
  is_hns_enabled                  = true
  allow_nested_items_to_be_public = false

  network_rules {
    default_action              = "Deny"
    bypass                      = ["AzureServices"] 
    ip_rules                    = var.whitelist_ip_addresses # passing in a list of strings
    virtual_network_subnet_ids  = var.allowed_subnets        # passing in a list of strings
  }
    
}

resource "azurerm_key_vault_secret" "storage-connection-string" {
  provider      = azurerm.spoke
  name          = "${azurerm_storage_account.this.name}-primary-connection-string" #"name" may only contain alphanumeric characters and dashes
  value         = azurerm_storage_account.this.primary_connection_string  
  key_vault_id  = azurerm_key_vault.this.id  
  depends_on    = [ 
    azurerm_storage_account.this,
    azurerm_role_assignment.keyvault_contributor_pipeline
  ]  
}

# Premium Function will write to this fileshare

resource "azurerm_storage_share" "function" {
  provider                      = azurerm.spoke
  name                          = local.azurerm_windows_function_app_name
  storage_account_id            = azurerm_storage_account.this.id
  quota                         = 50
}

# Container for misc
resource "azurerm_storage_container" "landingzone" {
  provider              = azurerm.spoke
  name                  = "landingzone"
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
  depends_on            = [ azurerm_storage_account.this ]
}