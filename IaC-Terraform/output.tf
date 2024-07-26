output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_node_rg" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}



output "aks_managed_identity_principal_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
}

output "aks_managed_identity_client_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity.0.client_id
}
