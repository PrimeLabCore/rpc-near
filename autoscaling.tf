resource "aws_autoscaling_group" "ecs" {
  name                      = "near-${var.environment}-${var.region}-ec2"
  max_size                  = var.ecs_asg_max_size
  min_size                  = var.ecs_asg_min_size
  desired_capacity          = var.ecs_asg_desired_capacity
  health_check_grace_period = 300
  health_check_type         = "EC2"
  launch_template {
    id      = aws_launch_template.ecs_indexer_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = module.near_vpc.private_subnets

  tag {
    key                 = "ecs_cluster_name"
    value               = module.ecs.ecs_cluster_name
    propagate_at_launch = true
  }

  depends_on = [
    module.near_vpc,
    aws_launch_template.ecs_indexer_launch_template
  ]
}