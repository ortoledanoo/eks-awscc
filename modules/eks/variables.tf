# EKS Module Variables
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of the private subnets"
  type        = list(string)
}

variable "security_group_ingress_cidr" {
  description = "CIDR block for security group ingress"
  type        = string
}

variable "security_group_egress_cidr" {
  description = "CIDR block for security group egress"
  type        = string
}

variable "cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  type        = string
}

# EKS Module Outputs
output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = awscc_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = awscc_eks_cluster.main.endpoint
}

output "cluster_arn" {
  description = "ARN of the EKS cluster"
  value       = awscc_eks_cluster.main.arn
}

output "cluster_version" {
  description = "Kubernetes version of the EKS cluster"
  value       = awscc_eks_cluster.main.version
}
