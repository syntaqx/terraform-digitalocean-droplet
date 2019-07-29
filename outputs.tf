output "droplet" {
  value = digitalocean_droplet.droplet
}

output "tls_private_key" {
  value     = tls_private_key.generated
  sensitive = true
}

output "digitalocean_ssh_key" {
  value = digitalocean_ssh_key.generated
}
