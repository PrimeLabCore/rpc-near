provider "aws" {
  region  = var.region
  profile = "cloud-account-administrator-464082997241"
  default_tags {
    tags = {
      Region     = var.region,
      Project    = "RPC",
      Created_By = "terraform",
      Owner      = "DevOps"
      Team       = "DevOps"
    }
  }
}