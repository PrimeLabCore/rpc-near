resource "aws_lb" "primelab_nlb" {
  for_each                   = var.primelab_nodes
  name                       = "${each.key}-${var.environment}-nlb"
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = module.near_vpc.public_subnets
  enable_deletion_protection = true
}

resource "aws_lb_target_group" "primelab_tg_3030" {
  for_each    = var.primelab_nodes
  name        = "${each.key}-${var.environment}-tg-3030"
  target_type = "ip"
  port        = 3030
  protocol    = "TCP"
  vpc_id      = module.near_vpc.vpc_id
}

resource "aws_lb_target_group" "primelab_tg_24567" {
  for_each    = var.primelab_nodes
  name        = "${each.key}-${var.environment}-tg-24567"
  target_type = "ip"
  port        = 24567
  protocol    = "TCP"
  vpc_id      = module.near_vpc.vpc_id
}

resource "aws_lb_listener" "primelab_node_listener_3030" {
  for_each          = var.primelab_nodes
  load_balancer_arn = aws_lb.primelab_nlb[each.key].arn
  port              = 3030
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primelab_tg_3030[each.key].arn
  }
}

resource "aws_lb_listener" "primelab_node_listener_24567" {
  for_each          = var.primelab_nodes
  load_balancer_arn = aws_lb.primelab_nlb[each.key].arn
  port              = 24567
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primelab_tg_24567[each.key].arn
  }
}