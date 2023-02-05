variable "resource_group_name" {
  type = string
}

variable "name" {
  type = string
}

variable "network_interface_id" {
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

variable "prefix" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}