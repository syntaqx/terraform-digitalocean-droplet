locals {
  count             = max(var.resource_count, 0)
  count_minus_hacks = lookup(var.hack, "create_before_destroy", false) == false && lookup(var.hack, "prevent_destroy", false) == false ? local.count : 0
  name              = format("%s-%s", var.name, var.region)
  private_key       = lookup(var.connection, "private_key", "")

  # Whether or not we should be generating a tls_private_key for connection
  generate_keypair = local.private_key == "" && local.count > 0 && var.fallback_ssh_keypair
}

resource "tls_private_key" "droplet" {
  count     = local.generate_keypair ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "digitalocean_ssh_key" "droplet" {
  count      = length(tls_private_key.droplet)
  name       = format("%s-%02d", local.name, count.index + var.count_start)
  public_key = tls_private_key.droplet[count.index].public_key_openssh
}

locals {
  ssh_keys        = concat(digitalocean_ssh_key.droplet[*].id, var.ssh_keys)
  ssh_private_key = local.generate_keypair ? tls_private_key.droplet[0].private_key_pem : local.private_key
}
