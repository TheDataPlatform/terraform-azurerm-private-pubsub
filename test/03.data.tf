# ------------ spoke data --------------------

data azurerm_resource_group "spoke" {
  provider              = azurerm.spoke
  name                  = local.spoke_rg_name
}

data "azurerm_virtual_network" "spoke" {
  provider              = azurerm.spoke
  name                  = local.spoke_vnet_name
  resource_group_name   = local.spoke_rg_name
}

data azurerm_subnet "private-endpoints-subnet" {
  provider              = azurerm.spoke
  name                  = "private-endpoints-subnet"
  virtual_network_name  = local.spoke_vnet_name
  resource_group_name   = local.spoke_rg_name
}

data azurerm_subnet "subnet-app-service-integration" {
  provider              = azurerm.spoke
  name                  = "subnet-app-service-integration"
  virtual_network_name  = local.spoke_vnet_name
  resource_group_name   = local.spoke_rg_name
}

# ------------ hub data --------------------

data "azurerm_private_dns_zone" "blob" {
  provider              = azurerm.hub
  name                  = "privatelink.blob.core.windows.net"
  resource_group_name   = local.hub_rg_name
}

data "azurerm_private_dns_zone" "queue" {
  provider              = azurerm.hub
  name                  = "privatelink.queue.core.windows.net"
  resource_group_name   = local.hub_rg_name
}

data "azurerm_private_dns_zone" "table" {
  provider              = azurerm.hub
  name                  = "privatelink.table.core.windows.net"
  resource_group_name   = local.hub_rg_name
}

data "azurerm_private_dns_zone" "file" {
  provider              = azurerm.hub
  name                  = "privatelink.file.core.windows.net"
  resource_group_name   = local.hub_rg_name
}

data "azurerm_private_dns_zone" "database" {
  provider              = azurerm.hub
  name                  = "privatelink.database.windows.net"
  resource_group_name   = local.hub_rg_name

}

data "azurerm_private_dns_zone" "azurewebsites" {
  provider              = azurerm.hub
  name                  = "privatelink.azurewebsites.net"
  resource_group_name   = local.hub_rg_name

}

data "azurerm_private_dns_zone" "servicebus" {
  provider              = azurerm.hub
  name                  = "privatelink.servicebus.windows.net"
  resource_group_name   = local.hub_rg_name
}