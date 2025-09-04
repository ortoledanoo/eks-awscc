# IAM Module Variables
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
}

# IAM Module Outputs
output "cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  value       = awscc_iam_role.eks_cluster.arn
}

output "fargate_role_arn" {
  description = "ARN of the EKS Fargate IAM role"
  value       = awscc_iam_role.eks_fargate.arn
}
