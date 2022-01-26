terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.31.1"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "test-rg"
    storage_account_name = "testsa"
    container_name       = "test-staging-blobstore"
    key                  = "test-staging"
  }
}

resource "azurerm_storage_container" "blobstore" {
  name                  = var.blobstore_name
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = var.cluster_name

  default_node_pool {
    name            = var.cluster_nodepool_name
    node_count      = var.cluster_nodepool_size
    vm_size         = var.cluster_vmsize
    availability_zones  = ["1"]
    #enable_auto_scaling = true
    #min_count           = 2
    #max_count           = 4
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "test-staging"
  }
}

output "kubernetes_cluster_name" {
  value = var.cluster_name
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}
