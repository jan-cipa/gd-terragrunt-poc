data "aws_region" "selected" {}

data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu_1804" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/*/ubuntu-bionic-18.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners = ["137112412989"] # Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

#data "vault_generic_secret" "test_password" {
#  path = "secret/v2/na1/dev/pi/data/test_1"
#}

#data "template_file" "instance_user_data" {
#  template = "${file("${path.module}/user_data.tpl")}"
#
#  vars = {
#    vault_test_secret = "${data.vault_generic_secret.test_password.data["tst"]}"
#  }
#}
#
