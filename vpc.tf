resource "aws_eip" "nat-eip" {
  count = 1

  domain = "vpc"
}

module "main-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-demo"
  cidr = "10.0.0.0/16"

  azs                 = ["${var.AWS_REGION}a", "${var.AWS_REGION}b", "${var.AWS_REGION}c"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  elasticache_subnets = ["10.0.31.0/24", "10.0.32.0/24"]
  database_subnets    = ["10.0.21.0/24", "10.0.22.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = false

  reuse_nat_ips       = true                    # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids = aws_eip.nat-eip.*.id  # <= IPs specified here as input to the module

  enable_dhcp_options = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
    Environment = var.ENV
  }
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.main-vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.main-vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.main-vpc.public_subnets
}

output "availability_zones" {
  description = "List of IDs of availability zones"
  value       = module.main-vpc.azs
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = module.main-vpc.elasticache_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.main-vpc.database_subnets
}