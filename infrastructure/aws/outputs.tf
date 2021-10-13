output "eks_cluster_endpoint" {
  value = aws_eks_cluster.aws_eks[0].endpoint
}

output "eks_cluster_certificat_authority" {
  value = aws_eks_cluster.aws_eks[0].certificate_authority 
}
