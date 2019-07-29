provider "digitalocean" {
}

module "droplet" {
  source = "../../"
  name   = "example"
}
