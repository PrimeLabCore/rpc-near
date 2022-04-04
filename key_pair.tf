resource "aws_key_pair" "ecs_node" {
  key_name   = "ecs-node"
  public_key = tls_private_key.ecs_node_ssh_key.public_key_openssh
}