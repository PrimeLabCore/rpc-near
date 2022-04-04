module "near_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name = "near-vpc"
  cidr = var.vpc_cidr

  map_public_ip_on_launch = false

  azs              = var.azs
  private_subnets  = var.private_subnets
  public_subnets   = var.public_subnets
  database_subnets = var.database_subnets

  public_dedicated_network_acl   = true
  private_dedicated_network_acl  = true
  database_dedicated_network_acl = true

  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  manage_default_vpc = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_classiclink             = false
  enable_classiclink_dns_support = false

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_vpn_gateway = true

  enable_dhcp_options              = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  flow_log_per_hour_partition          = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60
}