variable "pod_name" {
  type        = string
  description = "Pod name"
}

variable "resource_group_location" {
  type        = string
  description = "RG location in Azure"
}

variable "ftd_version" {
  type        = string
  description = "FTD Version"
}

variable "username" {
  type        = string
  description = "Username (don't use admin)"
}

variable "password" {
  type        = string
  description = "Password"
}

variable "fmc_ip" {
  type        = string
  description = "Password"
}