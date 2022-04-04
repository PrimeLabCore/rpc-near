module "near_vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = module.near_vpc.vpc_id
  security_group_ids = [module.near_vpc.default_security_group_id]

  endpoints = {
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = flatten([module.near_vpc.database_route_table_ids, module.near_vpc.private_route_table_ids, module.near_vpc.public_route_table_ids])
      policy          = data.aws_iam_policy_document.generic_endpoint_policy.json
      auto_accept     = true
      tags            = { Name = "rpc-${var.region}-s3-vpc-endpoint" }
    },
    rds = {
      service             = "rds"
      auto_accept         = true
      private_dns_enabled = true
      subnet_ids          = module.near_vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      security_group_ids  = [aws_security_group.vpc_postgres.id]
      tags                = { Name = "rpc-${var.region}-rds-vpc-endpoint" }
    },
    ssm = {
      service             = "ssm"
      auto_accept         = true
      private_dns_enabled = true
      subnet_ids          = module.near_vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      security_group_ids  = [aws_security_group.vpc_tls.id]
      tags                = { Name = "rpc-${var.region}-ssm-vpc-endpoint" }
    },
    ssmmessages = {
      service             = "ssmmessages"
      auto_accept         = true
      private_dns_enabled = true
      subnet_ids          = module.near_vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      security_group_ids  = [aws_security_group.vpc_tls.id]
      tags                = { Name = "rpc-${var.region}-ssm-messages-vpc-endpoint" }
    },
    ecs = {
      service             = "ecs"
      auto_accept         = true
      private_dns_enabled = true
      subnet_ids          = module.near_vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      security_group_ids  = [aws_security_group.vpc_tls.id]
      tags                = { Name = "rpc-${var.region}-ecs-vpc-endpoint" }
    },
    ecs_telemetry = {
      service             = "ecs-telemetry"
      auto_accept         = true
      private_dns_enabled = true
      subnet_ids          = module.near_vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      security_group_ids  = [aws_security_group.vpc_tls.id]
      tags                = { Name = "rpc-${var.region}-ecs-telemetry-vpc-endpoint" }
    },
    ec2 = {
      service             = "ec2"
      auto_accept         = true
      private_dns_enabled = true
      subnet_ids          = module.near_vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      security_group_ids  = [aws_security_group.vpc_tls.id]
      tags                = { Name = "rpc-${var.region}-ec2-vpc-endpoint" }
    },
    ec2messages = {
      service             = "ec2messages"
      auto_accept         = true
      private_dns_enabled = true
      subnet_ids          = module.near_vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      security_group_ids  = [aws_security_group.vpc_tls.id]
      tags                = { Name = "rpc-${var.region}-ec2-messages-vpc-endpoint" }
    },
    ecr_api = {
      service             = "ecr.api"
      auto_accept         = true
      private_dns_enabled = true
      subnet_ids          = module.near_vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      security_group_ids  = [aws_security_group.vpc_tls.id]
      tags                = { Name = "rpc-${var.region}-ecr-api-vpc-endpoint" }
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      auto_accept         = true
      private_dns_enabled = true
      subnet_ids          = module.near_vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      security_group_ids  = [aws_security_group.vpc_tls.id]
      tags                = { Name = "rpc-${var.region}-ecr-dkr-vpc-endpoint" }
    },
    elasticfilesystem = {
      service             = "elasticfilesystem"
      auto_accept         = true
      private_dns_enabled = true
      subnet_ids          = module.near_vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      security_group_ids  = [aws_security_group.vpc_tls.id]
      tags                = { Name = "rpc-${var.region}-efs-vpc-endpoint" }
    },
  }
}