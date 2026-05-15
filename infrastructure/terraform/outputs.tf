output "resource_group_name" {
  description = "Name of the shared Azure resource group."
  value       = module.resource_group.name
}

output "virtual_network_id" {
  description = "ID of the provisioned virtual network."
  value       = module.vnet.virtual_network_id
}

output "subnet_id" {
  description = "ID of the provisioned application subnet."
  value       = module.vnet.subnet_id
}

output "blob_storage_account_name" {
  description = "Name of the workload blob storage account."
  value       = module.blob_storage.storage_account_name
}

output "blob_storage_primary_blob_endpoint" {
  description = "Primary blob endpoint for the workload storage account."
  value       = module.blob_storage.primary_blob_endpoint
}

output "blob_container_names" {
  description = "Containers created in the workload storage account."
  value       = module.blob_storage.container_names
}

output "key_vault_uri" {
  description = "URI of the shared Azure Key Vault."
  value       = module.key_vault.vault_uri
}
