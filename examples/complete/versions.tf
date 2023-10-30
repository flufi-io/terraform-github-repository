terraform {
  required_version = "~> 1"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.41.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}
