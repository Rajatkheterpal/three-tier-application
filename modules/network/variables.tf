variable "address_space" {
  description = "address_space"
  type        = list(string)
}

variable "resource_group_name" {
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

variable "name_prefix" {
  type    = string
  default = "app"
}