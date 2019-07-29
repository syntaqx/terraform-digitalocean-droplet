provider "digitalocean" {
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "digitalocean_ssh_key" "example" {
  name       = "basic-example"
  public_key = tls_private_key.example.public_key_openssh
}

module "example_droplet" {
  source         = "../../"
  name           = "example"
  resource_count = 2
  ssh_keys       = [digitalocean_ssh_key.example.id]

  connection = {
    private_key = tls_private_key.example.private_key_pem
  }

  on_create = [
    "${path.module}/../../scripts/hello.sh",
  ]

  on_destroy = [
    "${path.module}/../../scripts/goodbye.sh",
  ]
}
