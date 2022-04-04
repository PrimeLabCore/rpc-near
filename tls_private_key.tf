resource "tls_private_key" "ecs_node_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}