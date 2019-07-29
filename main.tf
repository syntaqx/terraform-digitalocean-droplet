locals {
  name             = format("%s-%02d", var.name, count.index + var.count_start)
  private_key      = lookup(var.connection, "private_key", "")
  generate_keypair = local.private_key == "" && var.fallback_ssh_keypair
}

resource "tls_private_key" "droplet" {
  count     = local.generate_keypair ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "digitalocean_ssh_key" "droplet" {
  count      = length(tls_private_key.droplet)
  name       = local.name
  public_key = tls_private_key.droplet[count.index].public_key_openssh
}

locals {
  ssh_keys        = concat(digitalocean_ssh_key.droplet[*].id, var.ssh_keys)
  ssh_private_key = local.generate_keypair ? tls_private_key.droplet[0].private_key_pem : local.private_key
}

resource "digitalocean_droplet" "droplet" {
  count              = var.amount
  name               = local.name
  image              = var.image
  region             = var.region
  size               = var.size
  tags               = var.tags
  private_networking = true
  ipv6               = true
  monitoring         = var.monitoring
  backups            = var.backups
  resize_disk        = true
  user_data          = var.user_data
  volume_ids         = var.volume_ids
  ssh_keys           = local.ssh_keys

  connection {
    host        = self.ipv4_address
    type        = lookup(var.connection, "type", "ssh")
    timeout     = lookup(var.connection, "timeout", "2m")
    agent       = lookup(var.connection, "agent", false)
    user        = lookup(var.connection, "user", "root")
    private_key = local.ssh_private_key
  }

  # https://www.packer.io/docs/other/debugging.html#issues-installing-ubuntu-packages
  provisioner "remote-exec" {
    script = "${path.module}/scripts/wait-for-init.sh"
  }

  # https://github.com/hashicorp/terraform/issues/17844
  provisioner "remote-exec" {
    on_failure = "continue"
    inline = [
      "echo Rebooting instance...",
      "reboot &",
      "shutdown -r now",
    ]
  }

  # Allow the host some time to shutdown before reconnecting.
  # @TODO: This is a race condition that is unlikely, but still may fail. Fixme
  provisioner "local-exec" {
    command = "sleep 10"
  }
}
