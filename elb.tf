resource "aws_lb" "primelab_nlb" {
  name                       = "rpc-${var.environment}-nlb"
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = module.near_vpc.public_subnets
  enable_deletion_protection = true
}

resource "aws_lb_target_group" "primelab_tg_3030" {
  name        = "rpc-${var.environment}-tg-3030"
  target_type = "ip"
  port        = 3030
  protocol    = "TCP"
  vpc_id      = module.near_vpc.vpc_id
}

resource "aws_lb_target_group" "primelab_tg_24567" {
  name        = "rpc-${var.environment}-tg-24567"
  target_type = "ip"
  port        = 24567
  protocol    = "TCP"
  vpc_id      = module.near_vpc.vpc_id
}

resource "aws_lb_listener" "primelab_node_listener_3030" {
  load_balancer_arn = aws_lb.primelab_nlb.arn
  port              = 3030
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primelab_tg_3030.arn
  }
}

resource "aws_lb_listener" "primelab_node_listener_24567" {
  load_balancer_arn = aws_lb.primelab_nlb.arn
  port              = 24567
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primelab_tg_24567.arn
  }
}