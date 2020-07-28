variable "appId" {
	description = "AppID for credentials"
}

variable "password" {
	description = "password for credentials"
}

variable "cluster_name" {
	description = "As the name says name of the cluster."
}

variable "location" {
	description = "Region of the cluster."
}

variable "resource_group" {
	description = "Name of the resource group underwhich the cluster and the other resources should be created."
}

variable "storage_account" {
	description = "Name of the storage account."
}

variable "file_share_name" {
	description = "Name of the file share."
}
