# Private EKS Fargate Cluster with AWS Cloud Control (awscc) Provider Lightrail

private EKS cluster configuration using Fargate 

## Architecture:
- **VPC Module**: Networking infrastructure (VPC, subnets, route tables)
- **IAM Module**: Identity and access management roles
- **EKS Module**: EKS cluster and security groups

## After Deployment:
```bash
# Configure kubectl (requires VPN/Bastion for private cluster)
aws eks update-kubeconfig --region il-central-1 --name lightrail-eks-cluster

# Verify cluster
kubectl get nodes
```
