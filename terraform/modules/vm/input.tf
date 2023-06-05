
variable "rg_name" {
   default     = "Azuredevops"
   description = "Name of the resource group."
}

variable "rg_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "admin_username" {
  default     = "adminuser"
  description = "Location of the resource group."
}

variable "vm_name" {
  default     = "myVM"
  description = "Location of the resource group."
}

variable "nic_name" {
  default     = "myNetworkInterface"
  description = "Location of the resource group."
}

variable "rg_prefix" {	
  default     = "myRg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}
