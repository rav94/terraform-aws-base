terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0.0" #https://github.com/hashicorp/terraform-provider-aws/issues/23209
    }
    template = {
      source = "hashicorp/template"
    }
  }
}