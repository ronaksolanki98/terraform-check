module "terraform_state_blob" {
  source                   = "../modules/blob_storage"
  storage_account_name     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  container_names          = [var.container_name]
  account_tier             = "Standard"
  replication_type         = "LRS"
  access_tier              = "Hot"
  enable_versioning        = true
  allow_blob_public_access = false
  tags                     = var.tags
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
