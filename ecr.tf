resource "aws_ecr_repository" "near_rpc_for_primelab" {
  name                 = "near-rpc-for-primelab/${var.ecr_subrepositories}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}