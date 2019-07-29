variable "amount" {
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
  default     = "ubuntu-18-04"
}

# https://developers.digitalocean.com/documentation/v2/#list-all-sizes
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
  default     = null
}

variable "tags" {
  type        = list
  description = "A list of the tags to be applied to this Droplet"
  default     = []
}

variable "ssh_keys" {
  type        = list
  description = "A list of SSH IDs or fingerprints to enable in the format [12345, 123456]"
  default     = []
}

variable "volume_ids" {
  type        = list
  description = "A list of the IDs of each block storage volume to be attached to the Droplet"
  default     = []
}

variable "connection" {
  type = map
  default = {
    agent       = false
    type        = "ssh"
    user        = "root"
    private_key = null
    timeout     = "2m"
  }
}
