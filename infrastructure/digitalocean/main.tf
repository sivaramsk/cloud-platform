terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}


terraform {
  backend "s3" {
    endpoint                    = "<do_spaces_endpoint>"
    key                         = "terraform.tfstate"
    bucket                      = "<do_spaces_bucket_name>"
    region                      = "us-east-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}

data "digitalocean_ssh_key" "terraform" {
  name = var.do_ssh_key_name
}

resource "digitalocean_droplet" "vault" {
  image = var.do_vault_image_name
  name = var.do_vault_vm_name
  region = var.do_region
  size = var.do_vault_vm_size
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
}


data "external" "get_latest_do_k8s_version" {
  count   = var.enable_digitalocean ? 1 : 0
  program = ["sh", "${path.module}/get_do_latest_k8s_version.sh"]

  query = {
    do_token = var.do_token
  }
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  count   = var.enable_digitalocean ? 1 : 0
  name    = var.cluster_name
  region  = var.do_region
  version = data.external.get_latest_do_k8s_version[count.index].result["version"]

  node_pool {
    name       = var.do_k8s_pool_name
    size       = var.do_k8s_node_type
    node_count = var.do_k8s_nodes
  }
}

resource "local_file" "kubeconfigdo" {
  count    = var.enable_digitalocean ? 1 : 0
  content  = digitalocean_kubernetes_cluster.k8s[count.index].kube_config[0].raw_config
  filename = "${path.module}/kubeconfig_do"
}

