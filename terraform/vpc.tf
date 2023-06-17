module "eks-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name = var.vpc-name
  cidr = var.vpc-cidr

  azs             = var.vpc-azs
  public_subnets  = var.vpc-public-cidrs
  private_subnets = var.vpc-private-cidrs

  create_database_subnet_group    = false
  create_elasticache_subnet_group = false
  create_redshift_subnet_group    = false
  enable_nat_gateway              = true
  enable_vpn_gateway              = false
  enable_dns_hostnames            = true
  enable_dns_support              = true
  map_public_ip_on_launch         = false
  tags                            = local.tags
}
