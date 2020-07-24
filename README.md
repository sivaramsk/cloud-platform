# azure-aks

*Prerequisites:*
1. Azure account with the contributor role
2. Terraform 0.12 (https://www.terraform.io/downloads.html)
3. az (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

This would launch an AKS cluster along with 50G of filestore. 

*Deployment:*

*Checkout the repo:*
git clone https://github.com/sivaramkannan/azure-aks.git

Configure terraform:
  The default number of nodes that will be installed is 3 worker nodes with 4vCPUS and 16G RAM. Refer this page for configuring different machine type - https://azure.microsoft.com/en-in/pricing/details/virtual-machines/linux/. You can change the configuration in the file aks-cluster.tf under agent_pool_profile.count. 
  You can also change the configuration for the file store size in file-store.tf where the quota is set to 50G
  
Login to Azure:
1. Login to azure in your browser.
2. Execure `az login` from your command line. 
3. Follow the instructions to autheticate your command line. 

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

Destroy the cluster:
* `terraform destroy`

