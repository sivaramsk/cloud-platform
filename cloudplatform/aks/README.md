# azure-aks

*Prerequisites:*
1. Azure account with the contributor role
2. Terraform 0.12 (https://www.terraform.io/downloads.html)
3. az (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
4. Access to the repo git@github.com:sivaramkannan/BAF-intain-deployment-configs.git

This would launch an AKS cluster along with 50G of filestore. 

*Deployment:*

*Checkout the repo:*
git clone https://github.com/sivaramkannan/azure-aks.git
git clone git@github.com:sivaramkannan/BAF-intain-deployment-configs.git

Configure terraform:

  1. If it is a new deployment, create a new folder under BAF-intain-deployment-configs or use the existing folder if the deployment already exists.
  2. Copy the contents of the folder aks under azure-aks to the above folder.

  The default number of nodes that will be installed is 3 worker nodes with 4vCPUS and 16G RAM. Refer this page for configuring different machine type - https://azure.microsoft.com/en-in/pricing/details/virtual-machines/linux/. You can change the configuration in the file aks-cluster.tf under agent_pool_profile.count. 
  You can also change the configuration for the file store size in file-store.tf where the quota is set to 50G. You may have to modify the name of the storageaccount and the sharename if already using the default one. 
  
Login to Azure:
1. Login to azure in your browser.
2. Execure `az login` from your command line. 
3. Follow the instructions to autheticate your command line. 

Create Blob store for remote Statefile:
1. Go the storage account that would be used for this cluster creation.
2. Create a new container storage (blob store).
3. Mark the name of the new container created for subsequent usage.

Configure the variables wth the credentials:
1. Run the command `az ad sp create-for-rbac --skip-assignment`
```
$ az ad sp create-for-rbac --skip-assignment
{
  "appId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
  "displayName": "azure-cli-2019-04-11-00-46-05",
  "name": "http://azure-cli-2019-04-11-00-46-05",
  "password": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
  "tenant": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
}
```

3. Configure the appId and password from above in the terraform.tfvars

Launch the cluster:
* `terraform init` - If you are running terraform for the first time
* `terraform apply`

Add access details to kubectl: (don't overwrite the default set in ~/.kube/config)
* echo "$(terraform output kube_config)" > $HOME/.kube/azurek8s
* export KUBECONFIG="$HOME/.kube/azurek8s"

Destroy the cluster:
* `terraform destroy`

