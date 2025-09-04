# Private EKS Fargate cluster variables
aws_region                  = "il-central-1"
cluster_name                = "lightrail-eks-cluster"
environment                 = "dev"
kubernetes_version          = "1.33"
vpc_cidr                    = "10.0.0.0/16"
public_subnet_cidrs         = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs        = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones          = ["il-central-1a", "il-central-1b"]
security_group_ingress_cidr = "10.0.0.0/16"
security_group_egress_cidr  = "0.0.0.0/0"
fargate_profile_name        = "lightrail-eks-cluster-fargate-profile"
