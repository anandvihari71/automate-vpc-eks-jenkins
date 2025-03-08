#VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-mumbai-vpc"

  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.azs.names
  #private_subnets = var.private_subnets
  public_subnets          = var.public_subnets
  map_public_ip_on_launch = true

  #enable_nat_gateway = true
  #enable_vpn_gateway = true
  enable_dns_hostnames = true


  tags = {
    Name        = "jenkins-mumbai-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    Name = "jenkins_mumbai_public_subnet"
  }
}
#SG
module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Jenkins server"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Jenkins Server Only HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Only SSH"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    Name = "jenkins-sg"
  }
}

#JENKINS
module "ec2_instance_jenkins" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins server"

  instance_type               = var.instance_type
  key_name                    = "aws-keypair"
  monitoring                  = true
  vpc_security_group_ids      = [module.jenkins_sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  ami                         = data.aws_ami.example.id # ✅ Explicitly set AMI
  user_data                   = file("jenkins-install.sh")
  availability_zone           = data.aws_availability_zones.azs.names[0]

  tags = {
    Name        = "Jenkins server"
    Terraform   = "true"
    Environment = "dev"
  }
}

#IAM
