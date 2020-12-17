variable "resource_group" {
  description = "Resource groups for the fileshare and the blobstore"
}

variable "location" {
  description = "Azure location for the fileshare and the blob store."
}

variable "storage_account_name" {
  description = "Storage account name for the above fileshare and the blobstore."
}


variable "blobstore_name" {
  description = "Name of the blobstore"
}


variable "cluster_name" {
  description = "AKS Cluster name"
}

variable "cluster_nodepool_name" {
  description = "AKS cluster node pool"
}

variable "cluster_nodepool_size" {
  description = "Node pool size"
}

variable "cluster_vmsize" {
  description = "Worker node vmsize"
}

variable "prefix" {
  description = "prefix"
}

variable "vault_vmsize" {
  description = "Size of vault VM"
}
