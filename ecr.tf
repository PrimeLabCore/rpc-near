resource "aws_ecr_repository" "near_rpc_for_primelab" {
  count                = length(var.ecr_subrepositories)
  name                 = "near-for-primelab/${var.ecr_subrepositories[count.index]}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}