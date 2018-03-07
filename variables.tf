variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  default     = "serverless-test"
}

variable "region" {
  description = "Region where the resources are created."
  default = "westeurope"
}


variable "function_app_git_source" {
  description = "Region where the resources are created."
  default = "https://github.com/celaus/a-game-of-drones.git"
}


variable "function_app_name" {
  description = "The name of the function app that will host the functions"
  default     = "dronebiz2"
}

variable "storage_account_name" {
  description = "The name of the storage account for WebJobs"
  default     = "dronestore2"

  # the default name will be overwritten to fn0st0<appname> in the main code
}

variable "service_plan_name" {
  description = "The name of the App Service Plan"
  default     = "default"

  # the default name will be overwritten to fn0sp0<appname> in the main code
}

variable "service_plan_tier" {
  description = "Tier of VMs to use for Service Plan, default standard"
  default     = "standard"
}

variable "service_plan_size" {
  description = "VM size to deploy into the Service Plan, default S1"
  default     = "S1"
}

variable "service_plan_capacity" {
  description = "Number of VMs to deploy for the Service Plan"
  default     = 1
}

variable "version" {
  description = "The runtime version associated with the Function App. Possible values are ~1 and beta. Defaults to ~1."
  default     = "~1"
}

variable "app_settings" {
  description = "A key-value pair of App Settings."
  default = {}
}
