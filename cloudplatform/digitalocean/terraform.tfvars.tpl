cluster_name="k8s-performance-test"

endpoint=<backend_endpoint>
key="<prefix_key>"
bucket="<bucket_name>"
region="us-east-1"

do_ssh_key_name="<Name of the public ssh key added to the DO>"

vault_image_name="docker-20-04"
vault_vm_name="<Name of the vault vm to be created>"
vault_vm_region="<region_for_the_vm>"
vault_vm_size="s-1vcpu-1gb"
