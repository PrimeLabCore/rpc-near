provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::464082997241:role/NearPrimeOIDCDeploymentRole"
  }
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