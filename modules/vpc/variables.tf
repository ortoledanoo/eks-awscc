# VPC Module Variables
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
}

# VPC Module Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = awscc_ec2_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = awscc_ec2_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = awscc_ec2_subnet.private[*].id
}
