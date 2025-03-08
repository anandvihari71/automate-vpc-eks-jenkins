#I will get 32-21 =11 means 2 power 11 = 2048-2 IPS(1 for network, 1 for bradcast)
# out of 2048 IPs Im using 256*6= 1536 IPs im using in Subnets

vpc_cidr = "192.168.0.0/21"
az_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
# Each Subnet gets 32-24 = 8, means 2 power 8 = 256 IPS(-2 for nw and broadcast)
private_subnets = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24"]
public_subnets  = ["192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24"]
# so hear first subnet 1*256=256, second 2*256=512, like that 4096/256=16 that means
# staring first ip 192.168.0.0 ip and ending 192.168.7.255, im using till 5.255, i can even use
#192.168.6.0 to 192.168.6.255 and 192.168.7.0 to 192.168.7.255(last ip)

#public_subnets = ["192.168.4.0/24"]