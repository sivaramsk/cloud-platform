Amazon-EKS

Prerequisites:

    AWS IAM users for terraform and a group with the rights "AdministratorAccess" and "AmazonEKSClusterPolicy"
    Terraform 0.12 (https://www.terraform.io/downloads.html)

Deployment:

Checkout the repo: https://github.com/sivaramsk/cloud-platform.git

Configure terraform: The default number of nodes that will be installed is 3 worker nodes with t3.medium as instance type. You can modify the cluster name, scaling size, region as per your requirement in the file eks.tf

To install AWS CLI:

Follow the link https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html to install AWS CLI. Confirm the AWS CLI installation using the command aws --version.


Launch the cluster:

    terraform init - If you are running terraform for the first time
    terraform apply
    
To access the cluster via command line:

aws eks --region <cluster_region> update-kubeconfig --name <cluster_name>

To destroy the cluster:

    terraform destroy

