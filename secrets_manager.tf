resource "aws_secretsmanager_secret" "ecs_node_ssh_key" {
  name = "ecs-${var.region}-node-ssh-key"
}

resource "aws_secretsmanager_secret_version" "ecs_node_ssh_key" {
  secret_id     = aws_secretsmanager_secret.ecs_node_ssh_key.id
  secret_string = tls_private_key.ecs_node_ssh_key.private_key_pem
}