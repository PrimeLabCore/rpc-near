output "vpc_name" {
  description = "The name of the VPC specified as argument to this module"
  value       = module.near_vpc.name
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.near_vpc.vpc_id
}

output "vpc_azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = module.near_vpc.azs
}

output "vpc_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.near_vpc.default_security_group_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.near_vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.near_vpc.public_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.near_vpc.database_subnets
}

output "database_subnet_arns" {
  description = "List of ARNs of database subnets"
  value       = module.near_vpc.database_subnet_arns
}

output "database_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = module.near_vpc.database_subnets_cidr_blocks
}

output "database_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of database subnets in an IPv6 enabled VPC"
  value       = module.near_vpc.database_subnets_ipv6_cidr_blocks
}

output "database_subnet_group" {
  description = "ID of database subnet group"
  value       = module.near_vpc.database_subnet_group
}

output "database_subnet_group_name" {
  description = "Name of database subnet group"
  value       = module.near_vpc.database_subnet_group_name
}

output "private_subnet_cidrs" {
  description = "List of Private Subnet CIDR"
  value       = module.near_vpc.private_subnets_cidr_blocks
}
