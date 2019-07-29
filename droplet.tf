resource "digitalocean_droplet" "droplet" {
  count              = local.count_minus_hacks
  name               = format("%s-%02d", local.name, count.index + var.count_start)
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

  # https://www.terraform.io/docs/configuration/resources.html#lifecycle-lifecycle-customizations
  # @TODO: This exists as a hack to allow lifecycle to be passed into the module
  # - Error: Reserved block type name in module block
  # - The block type name "lifecycle" is reserved for use by Terraform in a future
  lifecycle {
    #lifecycle_hack
  }
}
