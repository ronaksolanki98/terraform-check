variable "storage_account_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "container_names" {
  type = set(string)
}

variable "account_tier" {
  type = string
}

variable "replication_type" {
  type = string
}

variable "access_tier" {
  type = string
}

variable "enable_versioning" {
  type = bool
}

variable "allow_blob_public_access" {
  type = bool
}

variable "tags" {
  type = map(string)
}
