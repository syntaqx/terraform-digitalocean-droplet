variable "name" {
  type        = string
  description = "The Droplet resource name"
}

variable "resource_count" {
  type        = number
  description = "Number of droplet resources to create"
  default     = 1
}

variable "resource_count_start" {
  type        = number
  description = "Resource name suffix count.index starting number"
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

variable "on_create" {
  description = "List of remote-exec provisioners for the host on creation"
  default     = []
}

variable "on_destroy" {
  description = "List of remote-exec provisioners for the host on destroy"
  default     = []
}
