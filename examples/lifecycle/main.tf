provider "digitalocean" {
}

module "droplet_lifecycle" {
  source = "../../"
  name   = "example"

  lifecycle_hack = {
    create_before_destroy = true
    prevent_destroy       = true
  }
}
