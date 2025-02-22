#I will get 32-20 =12 means 2 power 12 = 4096-2 IPS(1 for network, 1 for bradcast)
# out of 4094 IPs Im using 256*6= 1536 IPs im using in Subnets
vpc_cidr = "192.168.0.0/20"
az_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
# Each Subnet gets 32-24 = 8, means 2 power 8 = 256 IPS(-2 for nw and broadcast)
private_subnets = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
public_subnets  = ["192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
#public_subnets = ["192.168.4.0/24"]