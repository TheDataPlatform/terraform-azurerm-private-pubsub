# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server

resource "azurerm_mssql_server" "this" {
  provider                      = azurerm.spoke
  name                          = local.azurerm_mssql_server_name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  version                       = "12.0"
  administrator_login           = local.sql_server_admin_name
  administrator_login_password  = azurerm_key_vault_secret.sql_server.value
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"

  azuread_administrator {
    login_username  = local.azuread_administrator_login_username
    object_id       = local.azuread_administrator_object_id
  }
}

# This sku will technically be serverless
resource "azurerm_mssql_database" "this" {
  provider                      = azurerm.spoke
  name                          = local.azurerm_mssql_database_name
  server_id                     = azurerm_mssql_server.this.id
  collation                     = "SQL_Latin1_General_CP1_CI_AS"
  min_capacity                  = 0.5                               # .5 is lowest cpu available
  sku_name                      = "GP_S_Gen5_1"                     # _1 is the "max" CPU capacity
  enclave_type                  = "VBS"
  auto_pause_delay_in_minutes   = 60                                # 60 is minumum number of minutes.  -1 means always on

  lifecycle {
    prevent_destroy = false
  }
  
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id
    ]
  }
}

resource "random_password" "sql_server" {
  length            = 16
  special           = true
  override_special  = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "sql_server" {
  provider              = azurerm.spoke
  name                  = "sql-server-password"
  value                 = random_password.sql_server.result
  key_vault_id          = azurerm_key_vault.this.id
  depends_on            = [ random_password.sql_server, azurerm_role_assignment.keyvault_contributor_pipeline ]

}