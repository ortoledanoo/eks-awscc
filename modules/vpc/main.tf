# Simple VPC
resource "awscc_ec2_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = [
    {
      key   = "Name"
      value = "${var.cluster_name}-vpc"
    },
    {
      key   = "Environment"
      value = var.environment
    }
  ]
}

# Internet Gateway
resource "awscc_ec2_internet_gateway" "main" {
  tags = [
    {
      key   = "Name"
      value = "${var.cluster_name}-igw"
    },
    {
      key   = "Environment"
      value = var.environment
    }
  ]
}

# Public Subnets (for NAT Gateway)
resource "awscc_ec2_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = awscc_ec2_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  
  map_public_ip_on_launch = true
  
  tags = [
    {
      key   = "Name"
      value = "${var.cluster_name}-public-subnet-${count.index + 1}"
    },
    {
      key   = "Environment"
      value = var.environment
    }
  ]
}

# Private Subnets (for Fargate)
resource "awscc_ec2_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = awscc_ec2_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  
  tags = [
    {
      key   = "Name"
      value = "${var.cluster_name}-private-subnet-${count.index + 1}"
    },
    {
      key   = "Environment"
      value = var.environment
    },
    {
      key   = "kubernetes.io/role/internal-elb"
      value = "1"
    }
  ]
}

# Route Table for Public Subnets
resource "awscc_ec2_route_table" "public" {
  vpc_id = awscc_ec2_vpc.main.id
  
  tags = [
    {
      key   = "Name"
      value = "${var.cluster_name}-public-rt"
    },
    {
      key   = "Environment"
      value = var.environment
    }
  ]
}

# Route Table Association for Public Subnets
resource "awscc_ec2_subnet_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = awscc_ec2_subnet.public[count.index].id
  route_table_id = awscc_ec2_route_table.public.id
}

# Route Tables for Private Subnets
resource "awscc_ec2_route_table" "private" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = awscc_ec2_vpc.main.id
  
  tags = [
    {
      key   = "Name"
      value = "${var.cluster_name}-private-rt-${count.index + 1}"
    },
    {
      key   = "Environment"
      value = var.environment
    }
  ]
}

# Route Table Association for Private Subnets
resource "awscc_ec2_subnet_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = awscc_ec2_subnet.private[count.index].id
  route_table_id = awscc_ec2_route_table.private[count.index].id
}
