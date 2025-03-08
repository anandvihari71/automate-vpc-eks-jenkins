#VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = "eks-vpc"
  private_subnets = var.private_subnets
  cidr            = var.vpc_cidr

  azs = data.aws_availability_zones.azs.names
  #private_subnets = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = true
  single_nat_gateway = true

  #enable_nat_gateway = true
  #enable_vpn_gateway = true
  enable_dns_hostnames = true


  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }
}

# Security Group for EKS Worker Nodes
module "eks_worker_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "EKS Worker Nodes"
  description = "Security group for EKS worker nodes"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH access to Worker Nodes"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 1025
      to_port     = 65535
      protocol    = "tcp"
      description = "Node-to-node communication"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      description = "Allow ICMP ping"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name = "eks-worker-sg"
  }
}

# EKS Managed Node Group with Key Pair
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.31"

  bootstrap_self_managed_addons = false
  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    example = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t2.micro"]

      min_size     = 2
      max_size     = 5
      desired_size = 2
      
      key_name = "aws-keypair" # 🔥 Add Key Pair for SSH Access 🔥
      vpc_security_group_ids = [module.eks_worker_sg.security_group_id] # Attach SG
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}