# Im taking 32-21 =11 means 2 power 11= 2048-2(1 nw and 1 broadcast)
# first ip 10.0.0.0 last ip 10.0.7.255( last subnet starts 10.0.7.0 to 10.0.7.255)
# at present im using 3*256, 1*256 total 4 subnets, still i have 4 more subnets range
vpc_cidr        = "10.0.0.0/21"
az_zones        = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
private_subnets = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
#public_subnets= ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
public_subnets = ["10.0.3.0/24"]
instance_type  = "t2.small"