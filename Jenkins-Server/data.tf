data "aws_ami" "example" {

  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"
    #Few AMI won't suport SSH Login
    # al2023-ami-ecs-neuron-hvm-2023.0.20250224-kernel-6.1-x86_64
    # above ami won't support SSH Login, but below one support SSH Login
    values = ["al2023-ami-2023.6.20250218.2-kernel-6.1-x86_64"] # Updated for Amazon Linux 2023
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "azs" {}