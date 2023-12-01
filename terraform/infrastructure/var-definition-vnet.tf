# variable "vnet_hub_name" {
#   type    = string
#   # Add any other constraints or defaults if needed
# }

variable "address_space" {
  type    = list(string)
  # Add any other constraints or defaults if needed
}

variable "location" {
  type    = string
  # Add any other constraints or defaults if needed
}

variable "resource_group_name" {
  type    = string
  # Add any other constraints or defaults if needed
}
