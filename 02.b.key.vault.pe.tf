# =======================================================
# Setup Private Endpoint for KeyVault
# =======================================================

# Private Endpoint
resource "azurerm_private_endpoint" "keyvault" {
  provider            = azurerm.spoke
  name                = "private-endpoint-keyvault"
  location            = local.location
  resource_group_name = local.resource_group_name
  subnet_id           = local.keyvault-subnet #azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "keyvault-connection"
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"] # Target Key Vault subresource
    is_manual_connection           = false
  }
}

# resolves name and private ip address
resource "azurerm_private_dns_a_record" "kv_a_record" {
  provider            = azurerm.hub
  name                = azurerm_key_vault.this.name
  zone_name           = "privatelink.vaultcore.azure.net" #azurerm_private_dns_zone.keyvault.name
  resource_group_name = local.resource_group_name_hub
  ttl                 = 300
  records             = [azurerm_private_endpoint.keyvault.private_service_connection[0].private_ip_address]
}