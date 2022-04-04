resource "aws_ecs_task_definition" "primelab_nodes" {
  for_each = var.primelab_nodes
  family   = "${each.key}-${var.environment}-service"
  container_definitions = templatefile("${path.module}/task-definitions/primelab_node.json", {
    env                   = var.environment
    region                = var.region
    dockerTag             = each.value.dockerTag
    dockerRepo            = aws_ecr_repository.near_for_primelab[each.value.dockerRepo].repository_url
    config_param_store    = aws_ssm_parameter.node_config[each.key].name
    node_keys_param_store = aws_ssm_parameter.node_keys[each.key].name
    containerName         = each.value.container_name
  })
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  cpu                      = var.validator_node_cpu
  memory                   = var.validator_node_ram
}