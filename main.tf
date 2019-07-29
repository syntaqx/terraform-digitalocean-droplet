resource "digitalocean_droplet" "droplet" {
  count              = var.amount
  name               = format("%s-%02d", var.name, count.index + var.count_start)
  image              = var.image
  region             = var.region
  size               = var.size
  ssh_keys           = var.ssh_keys
  tags               = var.tags
  private_networking = true
  ipv6               = true
  monitoring         = true
  resize_disk        = true
  backups            = var.backups
  user_data          = var.user_data
  volume_ids         = var.volume_ids

  connection {
    host        = self.ipv4_address
    type        = lookup(var.connection, "type", "ssh")
    timeout     = lookup(var.connection, "timeout", "2m")
    agent       = lookup(var.connection, "agent", false)
    user        = lookup(var.connection, "user", "root")
    private_key = lookup(var.connection, "private_key", null)
  }

  # https://www.packer.io/docs/other/debugging.html#issues-installing-ubuntu-packages
  provisioner "remote-exec" {
    script = "${path.module}/scripts/wait-for-init.sh"
  }

  # https://github.com/hashicorp/terraform/issues/17844
  provisioner "remote-exec" {
    on_failure = "continue"
    inline = [
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
