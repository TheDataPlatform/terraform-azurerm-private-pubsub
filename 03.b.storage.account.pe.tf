# ==================================================================
# Blob Endpoint
# ==================================================================

resource "azurerm_private_endpoint" "storage_blob_state" {
  provider            = azurerm.spoke
  name                = "private-endpoint-blob-${azurerm_storage_account.this.name}"
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.storage-subnet

  private_service_connection {
    name                           = "private-service-connection-blob"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names = [
      "blob"
    ]
  }

  private_dns_zone_group {
    name                 = "storage-blob-private-dns-zone-group"
    private_dns_zone_ids = [ local.azurerm_private_dns_zone_blob ]  #[azurerm_private_dns_zone.blob_privatelink.id]
  }
}

# ==================================================================
# Queue Endpoint
# ==================================================================

resource "azurerm_private_endpoint" "storage_queue_state" {
  provider            = azurerm.spoke
  name                = "private-endpoint-queue-${azurerm_storage_account.this.name}"
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.storage-subnet

  private_service_connection {
    name                           = "private-service-connection-queue"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names = [
      "queue"
    ]
  }

  private_dns_zone_group {
    name                 = "storage-queue-private-dns-zone-group"
    private_dns_zone_ids = [ local.azurerm_private_dns_zone_queue ]  #[azurerm_private_dns_zone.queue_privatelink.id]
  }
}

# ==================================================================
# Table Endpoint
# ==================================================================

resource "azurerm_private_endpoint" "storage_table_state" {
  provider            = azurerm.spoke
  name                = "private-endpoint-table-${azurerm_storage_account.this.name}"
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.storage-subnet

  private_service_connection {
    name                           = "private-service-connection-table"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names = [
      "table"
    ]
  }

  private_dns_zone_group {
    name                 = "storage-table-private-dns-zone-group"
    private_dns_zone_ids = [  local.azurerm_private_dns_zone_table ]  #[azurerm_private_dns_zone.table_privatelink.id]
  }
}

# ==================================================================
# File Endpoint
# ==================================================================

resource "azurerm_private_endpoint" "storage_file_state" {
  provider            = azurerm.spoke
  name                = "private-endpoint-file-${azurerm_storage_account.this.name}"
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.storage-subnet
  
  private_service_connection {
    name                           = "private-service-connection-file"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names = [
      "file"
    ]
  }

  private_dns_zone_group {
    name                 = "storage-file-private-dns-zone-group"
    private_dns_zone_ids = [  local.azurerm_private_dns_zone_file ]  #[azurerm_private_dns_zone.file_privatelink.id]
  }
}