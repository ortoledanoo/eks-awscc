# Private EKS Fargate Cluster with AWS Cloud Control (awscc) Provider

A modular private EKS cluster configuration using Fargate for serverless container execution.

## Architecture:
- **VPC Module**: Networking infrastructure (VPC, subnets, route tables)
- **IAM Module**: Identity and access management roles
- **EKS Module**: EKS cluster and security groups

## What's Created:
- VPC with public and private subnets
- Internet Gateway (for future NAT Gateway)
- Private EKS Cluster (Kubernetes 1.33)
- Private endpoint only (no public access)
- Security group for internal traffic only
- IAM roles for EKS cluster and Fargate

## Quick Start:
```bash
terraform init
terraform plan
terraform apply
```

## After Deployment:
```bash
# Configure kubectl (requires VPN/Bastion for private cluster)
aws eks update-kubeconfig --region il-central-1 --name my-eks-cluster

# Create Fargate profile manually:
aws eks create-fargate-profile \
  --cluster-name my-eks-cluster \
  --fargate-profile-name my-eks-cluster-fargate-profile \
  --pod-execution-role-arn <fargate-role-arn-from-output> \
  --subnets <private-subnet-ids-from-output> \
  --region il-central-1

# Verify cluster
kubectl get nodes
```

## Module Structure:
```
├── main.tf              # Root configuration with module calls
├── variables.tf         # Root variables
├── outputs.tf           # Root outputs
├── terraform.tfvars     # Variable values
├── modules/
│   ├── vpc/
│   │   ├── main.tf      # VPC, subnets, route tables
│   │   └── variables.tf # VPC module variables and outputs
│   ├── iam/
│   │   ├── main.tf      # IAM roles and policies
│   │   └── variables.tf # IAM module variables and outputs
│   └── eks/
│       ├── main.tf      # EKS cluster and security groups
│       └── variables.tf # EKS module variables and outputs
```

## Features:
- **Modular Design**: Clean separation of concerns
- **Private Cluster**: No public endpoint access
- **Fargate Ready**: IAM roles configured for Fargate profiles
- **Private Subnets**: All workloads run in private subnets
- **Internal Traffic Only**: Security group restricts to VPC traffic
- **Reusable Modules**: Each module can be used independently
