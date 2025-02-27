variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
}

variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}

variable "node_resource_group" {
  type        = string
  description = "RG name for cluster resources in Azure"
}
variable "min_node_count" {
  type        = number
  description = "Minimum number of nodes in the AKS cluster's node pool for auto-scaling."
}

variable "max_node_count" {
  type        = number
  description = "Maximum number of nodes in the AKS cluster's node pool for auto-scaling."
}
variable "spn_name" {
  type        = string
  description = "Name of Service Principal"
}

variable "aad_group_aks_admins" {
  type        = string
  description = "Name of AAD group for AKS admins"
}

variable "grafana_admin_user" {
  type        = string
  description = "Admin user to access Grafana dashboard"
}

variable "grafana_admin_password" {
  type        = string
  description = "Admin password to access Grafana dashboard"
}

variable "harbor_admin_password" {
  type        = string
  description = "Admin password to access Harbor dashboard"
}