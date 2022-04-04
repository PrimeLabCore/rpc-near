module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "3.5.0"

  name               = "near-rpc-${var.environment}-${var.region}-cluster"
  capacity_providers = ["${aws_ecs_capacity_provider.ecs.name}", "FARGATE"]
  default_capacity_provider_strategy = [
    {
      capacity_provider = "${aws_ecs_capacity_provider.ecs.name}"
    }
  ]
  container_insights = true
}

resource "aws_ecs_capacity_provider" "ecs" {
  name = "indexer-${terraform.workspace}-${var.region}-ecs-capacity-provider"
  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ecs.arn
  }
}