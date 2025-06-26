# Existing Resources

data azurerm_resource_group "spoke" {
  name                  = "sandbox-rg"
}

data "azurerm_virtual_network" "spoke" {
  name                  = "sandbox-vnet"
  resource_group_name   = "sandbox-rg"
}

data azurerm_subnet "private-endpoints-subnet" {
  name                  = "private-endpoints-subnet"
  virtual_network_name  = "sandbox-vnet"
  resource_group_name   = "sandbox-rg"
}

data azurerm_subnet "subnet-app-service-integration" {
  name                  = "subnet-app-service-integration"
  virtual_network_name  = "sandbox-vnet"
  resource_group_name   = "sandbox-rg"
}

data "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "hub-rg"
  provider = azurerm.hub
}

data "azurerm_private_dns_zone" "queue" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = "hub-rg"
  provider = azurerm.hub
}

data "azurerm_private_dns_zone" "table" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = "hub-rg"
  provider = azurerm.hub
}

data "azurerm_private_dns_zone" "file" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = "hub-rg"
  provider = azurerm.hub
}

data "azurerm_private_dns_zone" "database" {
  name                = "privatelink.database.windows.net"
  resource_group_name = "hub-rg"
  provider = azurerm.hub
}

data "azurerm_private_dns_zone" "azurewebsites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "hub-rg"
  provider = azurerm.hub
}

data "azurerm_private_dns_zone" "servicebus" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = "hub-rg"
  provider = azurerm.hub
}