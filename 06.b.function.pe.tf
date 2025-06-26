resource "azurerm_private_endpoint" "sites_private_endpoint" {
  provider            = azurerm.spoke
  name                = "private-endpoint-sites-${azurerm_windows_function_app.this.name}"
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.application-subnet

  private_service_connection {
    name                           = "azurewebsites-private-service-connection"
    private_connection_resource_id = azurerm_windows_function_app.this.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sites-private-dns-zone-group"
    private_dns_zone_ids = [ local.azurerm_private_dns_zone_azurewebsites ]
  }
}