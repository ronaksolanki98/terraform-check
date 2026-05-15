variable "location" {
  description = "Azure region for the Terraform backend resources."
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Resource group name for the Terraform backend resources."
  type        = string
  default     = "devbridge-tfstate-rg"
}

variable "storage_account_name" {
  description = "Globally unique storage account name for Terraform state."
  type        = string
  default     = "devbridgetfstate01"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must be 3-24 characters and contain only lowercase letters and numbers."
  }
}

variable "container_name" {
  description = "Blob container name used for Terraform state."
  type        = string
  default     = "tfstate"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,63}$", var.container_name))
    error_message = "container_name must be 3-63 characters and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "tags" {
  description = "Common tags applied to the Terraform backend resources."
  type        = map(string)
  default = {
    project = "devbridge-platform"
    owner   = "platform-team"
    usage   = "terraform-state"
  }
}
