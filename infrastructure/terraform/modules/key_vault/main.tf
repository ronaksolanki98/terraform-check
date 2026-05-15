terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.30"
    }
  }
}

resource "azurerm_key_vault" "kv" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  purge_protection_enabled      = true
  soft_delete_retention_days    = 90
  enabled_for_disk_encryption   = true
  public_network_access_enabled = false
  tags                          = var.tags

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.owner_object_id

    secret_permissions = ["get", "list", "set"]
  }
}
