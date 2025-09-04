variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "il-central-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  default     = "1.33"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["il-central-1a", "il-central-1b"]
}

variable "security_group_ingress_cidr" {
  description = "CIDR block for security group ingress"
  type        = string
  default     = "10.0.0.0/16"
}

variable "security_group_egress_cidr" {
  description = "CIDR block for security group egress"
  type        = string
  default     = "0.0.0.0/0"
}

variable "fargate_profile_name" {
  description = "Name for the Fargate profile"
  type        = string
  default     = "my-eks-cluster-fargate-profile"
}
