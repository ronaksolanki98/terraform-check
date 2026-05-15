variable "location" {
  description = "Primary Azure location for resources."
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Name of the shared resource group."
  type        = string
  default     = "devbridge-platform-rg"
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
  default     = "devbridge-platform-vnet"
}

variable "vnet_address_space" {
  description = "Address space assigned to the virtual network."
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the application subnet."
  type        = string
  default     = "app-subnet"
}

variable "subnet_prefixes" {
  description = "Address prefixes assigned to the application subnet."
  type        = list(string)
  default     = ["10.1.1.0/24"]
}

variable "blob_storage_account_name" {
  description = "Globally unique Azure Storage Account name for workload blob storage."
  type        = string
  default     = "devbridgeplatblob01"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.blob_storage_account_name))
    error_message = "blob_storage_account_name must be 3-24 characters and contain only lowercase letters and numbers."
  }
}

variable "blob_container_names" {
  description = "Blob containers to create in the workload storage account."
  type        = set(string)
  default     = ["appdata"]

  validation {
    condition = alltrue([
      for container_name in var.blob_container_names :
      can(regex("^[a-z0-9-]{3,63}$", container_name))
    ])
    error_message = "Each blob container name must be 3-63 characters and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "blob_storage_account_tier" {
  description = "Performance tier for the workload storage account."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.blob_storage_account_tier)
    error_message = "blob_storage_account_tier must be either Standard or Premium."
  }
}

variable "blob_storage_replication_type" {
  description = "Replication type for the workload storage account."
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.blob_storage_replication_type)
    error_message = "blob_storage_replication_type must be a valid Azure Storage replication type."
  }
}

variable "blob_storage_access_tier" {
  description = "Access tier for the workload storage account."
  type        = string
  default     = "Hot"

  validation {
    condition     = contains(["Hot", "Cool"], var.blob_storage_access_tier)
    error_message = "blob_storage_access_tier must be either Hot or Cool."
  }
}

variable "enable_blob_versioning" {
  description = "Enable blob versioning for the workload storage account."
  type        = bool
  default     = true
}

variable "key_vault_name" {
  description = "Globally unique name of the Azure Key Vault."
  type        = string
  default     = "devbridge-platform-kv"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{3,24}$", var.key_vault_name))
    error_message = "key_vault_name must be 3-24 characters and contain only letters, numbers, and hyphens."
  }
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default = {
    project = "devbridge-platform"
    owner   = "platform-team"
  }
}
