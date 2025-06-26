# =======================================================
# Setup Private Endpoint for SQL Server
# =======================================================

# Private Endpoint
resource "azurerm_private_endpoint" "database" {
  provider              = azurerm.spoke
  name                  = "private-endpoint-database"
  resource_group_name   = local.resource_group_name
  location              = local.location
  subnet_id             = local.database-subnet

  private_service_connection {
    name                           = "sql-server-connection"
    private_connection_resource_id = azurerm_mssql_server.this.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"] # Connects the SQL Server
  }
}

# resolves name and private ip address
# review in portal: private dns zones -> private link -> dns management -> recordset -> look for the A record and Private IP
# resolves name and private ip address
resource "azurerm_private_dns_a_record" "database_a_record" {
  provider            = azurerm.hub
  name                = azurerm_mssql_server.this.name
  zone_name           = "privatelink.database.windows.net" #azurerm_private_dns_zone.database.name
  resource_group_name = local.resource_group_name_hub
  ttl                 = 300
  records             = [azurerm_private_endpoint.database.private_service_connection[0].private_ip_address]
}