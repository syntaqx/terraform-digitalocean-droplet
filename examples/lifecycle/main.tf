provider "digitalocean" {
}

module "droplet_create_before_destroy" {
  source = "../"
  name   = "example"

  hack = {
    create_before_destroy = true
  }
}

module "droplet_prevent_destroy" {
  source = "../"
  name   = "example"

  hack = {
    prevent_destroy = true
  }
}

module "droplet_create_create_before_destroy_before_destroy" {
  source = "../"
  name   = "example"

  hack = {
    create_before_destroy = true
    prevent_destroy       = true
  }
}
