### Roles
resource "aws_iam_role" "ecs_instance_role" {
  name = "ecs_instance_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.environment}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role.json
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.environment}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role.json
}

### Instance Profiles
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs_instance_profile"
  role = aws_iam_role.ecs_instance_role.name
}

### Policy
resource "aws_iam_role_policy" "ecs_task_execution_role_policy" {
  name   = "${aws_iam_role.ecs_task_execution_role.name}-policy"
  role   = aws_iam_role.ecs_task_execution_role.name
  policy = data.aws_iam_policy_document.ecs_task_execution_role_policy_doc.json
}

### Policy Attachments

resource "aws_iam_role_policy_attachment" "ecs_ssm_instance_attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = data.aws_iam_policy.ssm_instance.arn
}

resource "aws_iam_role_policy_attachment" "ecs_ssm_patch_attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = data.aws_iam_policy.ssm_patch.arn
}

resource "aws_iam_role_policy_attachment" "ecs_full_access_attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = data.aws_iam_policy.ecs_full_access.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_ssm_instance" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = data.aws_iam_policy.ssm_instance.arn
}