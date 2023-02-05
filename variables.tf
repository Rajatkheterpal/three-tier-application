variable "address_space" {
  description = "address_space"
  type        = list(string)
}

variable "location" {
  description = "The geo location to which resources are being deployed"
  type        = string
  default     = "East US"
}

variable "vm_name" {
  description = "Name of the VM"
  type        = list(string)
  default     = ["linux-1", "linux-2"]
}

variable "size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_B1s"
}

variable "resource_group_name" {
  description = "Name of the Application Resource Group"
  type        = string
  default     = "rg-d-tf-linux"
}

variable "kv_name" {
  description = "Name of the Azure Key Vault"
  type        = string
  default     = "kv-d-tf01"
}

variable "generic_vars" {
  description = "General variables for creating infrastructure"
  type        = any
}

variable "generic_vars_db" {
  description = "General variables for creating misql infrastructure"
  type        = any
}

variable "environment" {
  description = "The environment to which resources are being deployed"
  type        = string
  default     = "dev"
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."
  default = {
    environment = "dev"
  }
}

variable "sku_name" {
  type = string
}

variable "admin_username" {
  type = string
}