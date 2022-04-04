resource "aws_security_group" "vpc_tls" {
  name_prefix = "near-${var.region}-vpc_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.near_vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.near_vpc.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "ecs_node" {
  name        = "ecs-node-sg"
  description = "ECS Node Security Group"
  vpc_id      = module.near_vpc.vpc_id
  tags = {
    "Name" = "ecs-node-sg"
  }
}

resource "aws_security_group_rule" "ecs_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_node.id
}

resource "aws_security_group_rule" "node_nlb_ingress_3030" {
  for_each          = toset(module.near_vpc.public_subnets_cidr_blocks)
  type              = "ingress"
  from_port         = 3030
  to_port           = 3030
  protocol          = "tcp"
  cidr_blocks       = [each.key]
  security_group_id = aws_security_group.ecs_node.id
}

resource "aws_security_group_rule" "node_nlb_ingress_24567" {
  for_each          = toset(module.near_vpc.public_subnets_cidr_blocks)
  type              = "ingress"
  from_port         = 24567
  to_port           = 24567
  protocol          = "tcp"
  cidr_blocks       = [each.key]
  security_group_id = aws_security_group.ecs_node.id
}

resource "aws_security_group" "nlb_sg" {
  name        = "nlb-sg"
  description = "NLB Security Group"
  vpc_id      = module.near_vpc.vpc_id
  tags = {
    "Name" = "nlb-sg"
  }
}

resource "aws_security_group_rule" "nlb_ingress" {
  type              = "ingress"
  from_port         = 3030
  to_port           = 3030
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nlb_sg.id
}

resource "aws_security_group_rule" "nlb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nlb_sg.id
}

resource "aws_security_group" "vpc_postgres" {
  name_prefix = "near-${var.region}-vpc_postgres"
  description = "Allow PostgreSQL inbound traffic"
  vpc_id      = module.near_vpc.vpc_id

  ingress {
    description = "PostgreSQL from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [module.near_vpc.vpc_cidr_block]
  }
}