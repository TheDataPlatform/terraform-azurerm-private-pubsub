# Private Endpoint for the Service Bus Namespace
resource "azurerm_private_endpoint" "servicebus" {
  provider            = azurerm.spoke
  name                = "private-endpoint-servicebus-${azurerm_servicebus_namespace.this.name}"
  location            = local.location
  resource_group_name = local.resource_group_name
  subnet_id           = local.servicebus-subnet

  private_service_connection {
    name                           = "servicebus-private-service-connection"
    private_connection_resource_id = azurerm_servicebus_namespace.this.id
    subresource_names              = ["namespace"]  # this must be exactly "namespace"
    is_manual_connection           = false
  }

  # Optional: automatically integrate with DNS zone
  private_dns_zone_group {
    name                 = "sites-private-dns-zone-group"
    private_dns_zone_ids = [ local.azurerm_private_dns_zone_servicebus ]
  }

  depends_on = [ azurerm_servicebus_namespace.this ]
}