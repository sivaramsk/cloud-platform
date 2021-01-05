variable "cluster_name" {
  description = "Name of the Kubernetes cluster" 
  type = string
  default = ""
}

variable "pvt_key" {
  description = "Path of the private key"
  type = string
  default = ""
}

variable "enable_digitalocean" {
  description = "Enable / Disable Digital Ocean (e.g. `true`)"
  type        = bool
  default     = true
}

variable "do_token" {
  description = "Digital Ocean Personal access token"
  type        = string
  default     = ""
}

variable "do_region" {
  description = "Digital Ocean region (e.g. `sfo2` => SanFransico)"
  type        = string
  default     = "sfo2"
}

variable "do_k8s_name" {
  description = "Digital Ocean Kubernetes cluster name (e.g. `k8s-do`)"
  type        = string
  default     = "k8s-do"
}

variable "do_k8s_pool_name" {
  description = "Digital Ocean Kubernetes default node pool name (e.g. `k8s-do-nodepool`)"
  type        = string
  default     = "k8s-mainpool"
}

variable "do_k8s_nodes" {
  description = "Digital Ocean Kubernetes default node pool size (e.g. `2`)"
  type        = number
  default     = 3
}

variable "do_k8s_node_type" {
  description = "Digital Ocean Kubernetes default node pool type (e.g. `s-1vcpu-2gb` => 1vCPU, 2GB RAM)"
  type        = string
  default     = "s-1vcpu-2gb"
}

variable "do_k8s_nodepool_name" {
  description = "Digital Ocean Kubernetes additional node pool name (e.g. `k8s-do-nodepool`)"
  type        = string
  default     = "k8s-nodepool"
}


variable "do_vault_image_name" {
  description = ""
  type = string
  default = "docker-20-04"
}

variable "do_vault_vm_name" {
  description = "Name of the vault vm for this instance."
  type = string
  default = ""
}

variable "do_vault_vm_size" {
  description = "Type of the vm machine for this vm."
  type = string
  default = "s-1vcpu=1gb"
}

variable "do_ssh_key_name" {
  description = "Name of the public ssh key to add to the VM created."
  type = string
  default = ""
}
