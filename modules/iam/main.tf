# EKS Cluster IAM Role
resource "awscc_iam_role" "eks_cluster" {
  role_name = "${var.cluster_name}-cluster-role"
  
  assume_role_policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
  
  # EKS Cluster Policy
  policies = [
    {
      policy_name = "AmazonEKSClusterPolicy"
      policy_document = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "eks:*"
            ]
            Resource = "*"
          }
        ]
      })
    }
  ]
  
  tags = [
    {
      key   = "Name"
      value = "${var.cluster_name}-cluster-role"
    },
    {
      key   = "Environment"
      value = var.environment
    }
  ]
}

# Fargate Profile IAM Role
resource "awscc_iam_role" "eks_fargate" {
  role_name = "${var.cluster_name}-fargate-role"
  
  assume_role_policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks-fargate-pods.amazonaws.com"
        }
      }
    ]
  })
  
  # Fargate Pod Execution Role Policy
  policies = [
    {
      policy_name = "AmazonEKSFargatePodExecutionRolePolicy"
      policy_document = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "ecr:GetAuthorizationToken",
              "ecr:BatchCheckLayerAvailability",
              "ecr:GetDownloadUrlForLayer",
              "ecr:BatchGetImage",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ]
            Resource = "*"
          }
        ]
      })
    }
  ]
  
  tags = [
    {
      key   = "Name"
      value = "${var.cluster_name}-fargate-role"
    },
    {
      key   = "Environment"
      value = var.environment
    }
  ]
}
