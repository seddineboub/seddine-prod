//----------------------------------------------------------------------------------------//
// variables values for --> DNS PRIVATE ZONE
variable "aks_dns_zone_name" {
  description = "Name for the AKS DNS zone"
  type        = string
  default     = "aksdns.private.westus.azmk8s.io"
}
//----------------------------------------------------------------------------------------//
// variable values for --> AKS
variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
  default     = "aks-prd"
}

variable "aks_dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
  default     = "AksPrdDns"
}

variable "aks_node_pool_name" {
  description = "The name of the default node pool"
  type        = string
  default     = "akspoolprd"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default = "1.26.3"
}
variable "aks_node_count" {
  description = "The number of nodes in the default node pool"
  type        = number
  default     = 3
}

variable "aks_node_vm_size" {
  description = "The VM size for the nodes in the default node pool"
  type        = string
  default     = "Standard_B2s"
}

variable "aks_node_os_disk_size_gb" {
  description = "The OS disk size in GB for the nodes in the default node pool"
  type        = number
  default     = 30
}

variable "client_id" {
  description = "Client id for auth - current account"
    type = string
    default = "3d5c2f8b-286d-45fc-8ce0-9f1b9d6914a5"
}
variable "client_secret" {
  description = "Client secret for auth - current account"
    type = string
    default = "XC-8Q~2lyQnLYwEcYMVtF9OsD40QNAyuDAHF0bKP"
}



