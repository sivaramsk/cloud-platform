resource "digitalocean_droplet" "vault" {
  image = "docker-20-04"
  name = "<vault-vm-name>"
  region = "<vm-region-of-deployment>"
  size = "s-1vcpu-1gb"
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
