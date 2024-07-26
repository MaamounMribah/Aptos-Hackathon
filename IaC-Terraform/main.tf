resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
  node_resource_group = var.node_resource_group

  default_node_pool {
    name       = "system"
    node_count = var.system_node_count
    vm_size    = "Standard_DS2_v2"
    type       = "VirtualMachineScaleSets"
    #availability_zones  = [1, 2, 3]
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 1
  }
  

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" # azure (CNI)
  }
}


### providing nginx ingress controller ###
resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  timeout = 1000
  recreate_pods = true
  dependency_update = true
  cleanup_on_fail = true

  set {
    name  = "controller.service.loadBalancerIP"
    value = 35.198.97.209
  }
  set {
    name  = "controller.hostPort.enabled"
    value = "true"
  }

}

resource "kubernetes_ingress_v1" "express-ingress" {
  metadata {
    name = "express-ingress"
    annotations = {
      "cert-manager.io/cluster-issuer"          = "letsencrypt-issuer"
      "nginx.ingress.kubernetes.io/enable-cors"= "true"
      "nginx.ingress.kubernetes.io/cors-allow-origin"= "*"
    }
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      host = "aptos-ai-sec.int-infra.com"
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "aptos-app-service"
              port {
                number = 91
              }
            }
          }
        }
      }
    }
  }
}