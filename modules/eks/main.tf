# Private EKS Cluster for Fargate
resource "awscc_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version
  
  resources_vpc_config = {
    subnet_ids              = var.private_subnet_ids
    security_group_ids      = [awscc_ec2_security_group.eks_cluster.id]
    endpoint_private_access = true
    endpoint_public_access  = false
  }
  
  tags = [
    {
      key   = "Name"
      value = var.cluster_name
    },
    {
      key   = "Environment"
      value = var.environment
    }
  ]
}

# Security Group for Private EKS Cluster
resource "awscc_ec2_security_group" "eks_cluster" {
  group_name        = "${var.cluster_name}-cluster-sg"
  group_description = "Security group for private EKS cluster"
  vpc_id            = var.vpc_id
  
  # Allow internal traffic only
  security_group_ingress = [
    {
      description = "Allow internal traffic"
      ip_protocol = "-1"
      cidr_ip     = var.security_group_ingress_cidr
    }
  ]
  
  security_group_egress = [
    {
      description = "Allow all outbound traffic"
      ip_protocol = "-1"
      cidr_ip     = var.security_group_egress_cidr
    }
  ]
  
  tags = [
    {
      key   = "Name"
      value = "${var.cluster_name}-cluster-sg"
    },
    {
      key   = "Environment"
      value = var.environment
    }
  ]
}
