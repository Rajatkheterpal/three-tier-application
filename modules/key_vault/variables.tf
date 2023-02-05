variable "resource_group_name" {
  type = string
}

variable "kv_name" {
  type = string
}

variable "location" {
  description = "The geo location to which resources are being deployed"
  type        = string
  default     = "East US"
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."
  default = {
    environment = "dev"
  }
}

variable "tenant_id" {
  type = string
}

variable "object_id" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "soft_delete_retention_days" {
  type = string
}