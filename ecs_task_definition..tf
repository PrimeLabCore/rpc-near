resource "aws_ecs_task_definition" "primelab_nodes" {
  family = "rpc-${var.environment}-service"
  container_definitions = templatefile("${path.module}/task-definitions/rpc_node.json", {
    env           = var.environment
    region        = var.region
    dockerTag     = var.docker_tag
    dockerRepo    = aws_ecr_repository.near_rpc_for_primelab.repository_url
    containerName = var.container_name
  })
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  cpu                      = var.rpc_node_cpu
  memory                   = var.rpc_node_ram
}