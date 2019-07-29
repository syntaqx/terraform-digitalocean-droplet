variable "resource_count" {
  type        = number
  description = "Number of droplet resources to create"
  default     = 1
}

variable "name" {
  type        = string
  description = "The Droplet name"
}

variable "count_start" {
  type        = number
  description = "Name counter starting number"
  default     = 1
}

variable "image" {
  type        = string
  description = "The Droplet ID or slug"
  default     = "docker-18-04"
}

# https://developers.digitaloceanfcom/documentation/v2/#list-all-sizes
variable "size" {
  type        = string
  description = "The unique slug that indentifies the type of Droplet"
  default     = "s-1vcpu-1gb"
}

variable "region" {
  type        = string
  description = "The DigitalOcean region to create the droplet in"
  default     = "nyc3"
}

variable "user_data" {
  type        = string
  description = "A string of the desired User Data for the Droplet"
  default     = "#!/bin/bash"
}

variable "tags" {
  type        = list(any)
  description = "A list of the tags to be applied to this Droplet"
  default     = []
}

variable "ssh_keys" {
  type        = list(any)
  description = "A list of SSH IDs or fingerprints to enable in the format [12345, 123456]"
  default     = []
}

variable "volume_ids" {
  type        = list(any)
  description = "A list of the IDs of each block storage volume to be attached to the Droplet"
  default     = []
}

variable "backups" {
  type        = bool
  description = "Enable backups"
  default     = false
}

variable "monitoring" {
  type        = bool
  description = "Enable detailed monitoring"
  default     = true
}

variable "connection" {
  type = map
  default = {
    agent       = false
    type        = "ssh"
    user        = "root"
    private_key = ""
    timeout     = "2m"
  }
}

# An SSH keypair is generated when none is configured so that Terraform is able
# to use the remote-exec provisioner. If you don't need to specify a keypair
# (ie, when using the hosts ssh agent) you can disable this.
variable "fallback_ssh_keypair" {
  type        = bool
  description = "Generate an SSH keypair used as a fallback when none is configured"
  default     = true
}

# Hacks to access values we're not supposed to be able to
variable "hack" {
  type = map
  default = {
    create_before_destroy = false
    prevent_destroy       = false
  }
}
