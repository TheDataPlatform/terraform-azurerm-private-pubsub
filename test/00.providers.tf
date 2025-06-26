provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id                   = var.subscription_id
  resource_provider_registrations  = "none"
}

# sandbox Provider (with Alias)
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id                   = var.subscription_id
  resource_provider_registrations   = "none"
  alias                             = "spoke"
}

# hub Provider (with Alias)
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id                   = var.hub_subscription_id
  resource_provider_registrations   = "none"
  alias                             = "hub"
}

# Environment Variable: TF_VAR_subscription_id
variable "subscription_id" {
  description = "Azure Subscription ID to deploy into"
  type        = string
  default     = null
}


# Environment Variable: TF_VAR_hub_subscription_id
variable "hub_subscription_id" {
  description = "Azure Subscription ID to deploy into"
  type        = string
  default     = null
}