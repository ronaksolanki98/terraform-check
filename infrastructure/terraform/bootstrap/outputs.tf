output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "storage_account_name" {
  value = module.terraform_state_blob.storage_account_name
}

output "container_name" {
  value = one(module.terraform_state_blob.container_names)
}
