terraform {
  required_version = ">= 1.0"

  backend "local" {
    path = ".state/terraform.tfstate"
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.12.0"
    }
  }
}
