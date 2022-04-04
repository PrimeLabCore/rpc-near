region = "us-east-1"
environment = "dev"
azs = [
  "us-east-1a",
  "us-east-1c",
  "us-east-1e"
]
vpc_cidr = "10.0.0.0/16"
private_subnets = [
  "10.0.0.0/24",
  "10.0.1.0/24",
  "10.0.2.0/24"
]
public_subnets = [
  "10.0.10.0/24",
  "10.0.11.0/24",
  "10.0.12.0/24"
]
database_subnets = [
  "10.0.20.0/24",
  "10.0.21.0/24",
  "10.0.22.0/24"
]
ecr_subrepositories = "rpc"