provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = var.RoleArn
  }
}

provider "aws" {
  region = var.aws_region
  alias  = "build-infra"
  assume_role {
    role_arn = var.DBRoleArn
  }
}
