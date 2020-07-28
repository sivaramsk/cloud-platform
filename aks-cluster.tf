
provider "azurerm" {
  version = "~> 2.20.0"

  features {}
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = "intain-dev-rg"
  dns_prefix          = var.cluster_name

  default_node_pool {
    name            = "default"
    node_count           = 1
    vm_size         = "Standard_D4a_v4"
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }
}

output "kubernetes_cluster_name" {
  value = var.cluster_name
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.default.kube_config_raw
}
