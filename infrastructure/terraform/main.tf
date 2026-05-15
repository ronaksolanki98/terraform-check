data "azurerm_client_config" "current" {}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source              = "./modules/vnet"
  name                = var.vnet_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space       = var.vnet_address_space
  subnet_name         = var.subnet_name
  subnet_prefixes     = var.subnet_prefixes
  tags                = var.tags
}

module "blob_storage" {
  source                   = "./modules/blob_storage"
  storage_account_name     = var.blob_storage_account_name
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  container_names          = var.blob_container_names
  account_tier             = var.blob_storage_account_tier
  replication_type         = var.blob_storage_replication_type
  access_tier              = var.blob_storage_access_tier
  enable_versioning        = var.enable_blob_versioning
  allow_blob_public_access = false
  tags                     = var.tags
}

module "key_vault" {
  source              = "./modules/key_vault"
  name                = var.key_vault_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  owner_object_id     = data.azurerm_client_config.current.object_id
  tags                = var.tags
}
