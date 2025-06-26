# Premium for private endpoints
resource "azurerm_servicebus_namespace" "this" {
  provider                      = azurerm.spoke
  name                          = local.azurerm_servicebus_namespace_name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  sku                           = "Premium"
  capacity                      = 1  # 1, 2, 4, 8, or 16
  premium_messaging_partitions  = "1"
}

resource "azurerm_servicebus_queue" "this" {
  provider                      = azurerm.spoke
  name                          = local.azurerm_servicebus_queue_name
  namespace_id                  = azurerm_servicebus_namespace.this.id
}


# Assign RBAC role for Function to send messages
resource "azurerm_role_assignment" "function_send" {
  provider             = azurerm.spoke
  scope                = azurerm_servicebus_queue.this.id
  role_definition_name = "Azure Service Bus Data Sender"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

# Assign RBAC role for Function to receive messages
resource "azurerm_role_assignment" "function_receive" {
  provider             = azurerm.spoke
  scope                = azurerm_servicebus_queue.this.id
  role_definition_name = "Azure Service Bus Data Receiver"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}