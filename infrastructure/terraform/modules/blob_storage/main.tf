terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.30"
    }
  }
}

resource "azurerm_storage_account" "this" {
  name                              = var.storage_account_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = var.account_tier
  account_replication_type          = var.replication_type
  access_tier                       = var.access_tier
  min_tls_version                   = "TLS1_2"
  allow_nested_items_to_be_public   = var.allow_blob_public_access
  shared_access_key_enabled         = false
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  tags                              = var.tags

  blob_properties {
    versioning_enabled = var.enable_versioning
  }

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }
}

resource "azurerm_storage_container" "this" {
  for_each              = var.container_names
  name                  = each.value
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}
