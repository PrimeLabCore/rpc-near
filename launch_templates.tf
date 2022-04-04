resource "aws_launch_template" "ecs_indexer_launch_template" {
  name          = "near-${var.environment}-${var.region}-ec2-launch-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.ecs_instance_type
  user_data = base64encode(templatefile("${path.module}/userdata/ecs_user_data.sh", {
    ECSClusterName = module.ecs.ecs_cluster_name
  }))
  ebs_optimized          = true
  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      encrypted             = true
      delete_on_termination = true
      volume_type           = "gp3"
      volume_size           = 5000
      throughput            = 400
      iops                  = 5000
    }
  }

  key_name = aws_key_pair.ecs_node.key_name

  vpc_security_group_ids = [
    aws_security_group.ecs_node.id
  ]

  monitoring {
    enabled = true
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "near-${var.environment}-${var.region}-ec2-node"
    }
  }

  #checkov:skip=CKV_AWS_79:Default requires metadata v2
  metadata_options {
    http_endpoint      = "enabled"
    http_tokens        = "optional"
    http_protocol_ipv6 = "disabled"
  }
}