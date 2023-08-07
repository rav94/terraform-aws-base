terraform {
  cloud {
    organization = "ravnf-personal"

    workspaces {
      name = "terraform-base-demo"
    }
  }
}