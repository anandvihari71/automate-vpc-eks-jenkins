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

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.31"

  bootstrap_self_managed_addons = false


  # Optional
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id = module.vpc.vpc_id
  # I want to deploy eks in privte subnet
  subnet_ids = module.vpc.private_subnets



  # EKS Managed Node Group(s)


  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t2.medium"]

      min_size     = 2
      max_size     = 5
      desired_size = 2
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}