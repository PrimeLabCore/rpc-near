resource "aws_ecs_service" "rpc_node_service" {
  name                   = "${rpc}-${var.environment}-service"
  cluster                = module.ecs.ecs_cluster_id
  task_definition        = aws_ecs_task_definition.primelab_nodes[each.key].arn
  enable_execute_command = true
  desired_count          = 1
  launch_type            = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.primelab_tg_3030[each.key].arn
    container_name   = each.value.container_name
    container_port   = 3030
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.primelab_tg_24567[each.key].arn
    container_name   = each.value.container_name
    container_port   = 24567
  }
  network_configuration {
    subnets          = module.near_vpc.private_subnets
    assign_public_ip = false
    security_groups = [
      aws_security_group.ecs_node.id
    ]
  }
}