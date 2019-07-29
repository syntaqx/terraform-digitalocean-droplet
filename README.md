# Terraform DigitalOcean Droplet

Terraform module for provisioning DigitalOcean droplet(s) with sane defaults.

## Features

- Asserts cloud-init is completed before resource creation completes
- Generates a per-instance TLS keypair for SSH provisioner if none is provided

### Lifecycle Hack

Since resource lifecycles are not configurable the various permutations of a
droplet's lifecycle states are generated into `droplet_lifecycle_hacks.tf` for
ease of use. I'm not entirely sure how to do this any cleaner so that'll have to
do for now.

## License

[MIT]: https://opensource.org/licenses/MIT

This project is open source software released under the [MIT license][MIT].
