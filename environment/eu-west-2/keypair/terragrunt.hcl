terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-key-pair.git?ref=v0.3.0"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../aws-data"]
}

dependency "aws-data" {
  config_path = "../aws-data"
}

inputs = {
  key_name = "gd-keypair"
  create_key_pair = true
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKFoVpZK5gfz3oGnbR6TkMcDrxJ8JhAi/xBo/ssCVutkdNgPUdwesfKF9BzV3S7NZevTUr89Z6zvCVXjM8CySswovAR7jf7nTPNX6J7xmfbe77cX1dn8ibRGH4cJ8Dqj0QRwOEzCkrKtydqdscT/ivEOI7VeaitXH9npEAbUA2crHOw7V0whm7rLdyXbr3joErsqPH3BQwLx4ZpNdfTx3dJDv/KK1geNMgF3irWQ5g1Yf3MX9sU1qsusxaH25WC4D3JNwasNyYR/H5OgzAArSKSRYn1MXCVOJrEgOQR4XXWO7vzUHKwuxVTI9Ic1KtBd/xRQokhh0zFvUaheHJSlVH root@jci-maslostroj"
}
