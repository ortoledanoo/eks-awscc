provider "awscc" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  environment          = var.environment
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# IAM Module
module "iam" {
  source = "./modules/iam"

  cluster_name = var.cluster_name
  environment  = var.environment
}

# EKS Module
module "eks" {
  source = "./modules/eks"

  cluster_name                = var.cluster_name
  kubernetes_version          = var.kubernetes_version
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  private_subnet_ids          = module.vpc.private_subnet_ids
  security_group_ingress_cidr = var.security_group_ingress_cidr
  security_group_egress_cidr  = var.security_group_egress_cidr
  cluster_role_arn            = module.iam.cluster_role_arn
}
