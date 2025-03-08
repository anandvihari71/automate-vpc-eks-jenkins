variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "az_zones" {
  description = "Availability Zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private Subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public Subnets"
  type        = list(string)
}

variable "instance_type" {
  description = "Jenkins Intance Type"
  type        = string

}