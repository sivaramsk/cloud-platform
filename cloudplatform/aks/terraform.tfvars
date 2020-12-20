# Resource Group
resource_group = "umb-rg"
location = "West Europe"

# Storage Account Name" 
storage_account_name = "umbsa"

# Blobstore configuration
blobstore_name = "umb-blobstore"

# Azure AKS configuration
cluster_name = "umb-staging"
cluster_nodepool_name = "default"
cluster_vmsize = "Standard_D11_v2"
cluster_nodepool_size = 5

#Vault VM Configuration
prefix = "umb-staging"
vault_vmsize = "Standard_DS1_v2"
