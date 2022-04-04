provider "aws" {
  region = var.region
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