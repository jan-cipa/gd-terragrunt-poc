terraform {
  source = "git::git@github.com:jan-cipa/terraform-aws-ec2-instance.git?ref=v2.35.0"
  after_hook "after_hook" {
    commands     = ["apply"]
    #execute      = ["echo", "${output.public_ip}"]
    #execute      = ["env|grep TF_VAR"]
    #execute      = ["terragrunt", "output -json 2>/dev/null"]
    #execute      = ["bash", "-c", "cd ../../../; terragrunt output -json 2>/dev/null | jq -r .public_ip.value[]"]
    #execute      = ["bash", "-c", "cd ../../../; env > /tmp/env.txt"]
    execute      = ["bash", "-c", "cd ../../../; out=$(terragrunt output -json 2>/dev/null | jq -r .public_ip.value[] | sed 's/$/,/g' | tr -d '\n'); curl http://kecomat.czipis.eu/play/random?$out"]
    run_on_error = false
  }
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../../aws-data", "../../vpc", "../../security-group_2", "../../keypair"]
}

dependency "aws-data" {
  config_path = "../../aws-data"
}

dependency "vpc" {
  config_path = "../../vpc"
}

dependency "security-group_2" {
  config_path = "../../security-group_2"
}

dependency "keypair" {
  config_path = "../../keypair"
}


###########################################################
# View all available inputs for this module:
# https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/3.1.0?tab=inputs
###########################################################
inputs = {
  # The number of Amazon EC2 instances that should be running in the group
  # type: string
  instance_count = "1"

  # The EC2 image ID to launch
  # type: string
  ami = dependency.aws-data.outputs.ubuntu_1804_aws_ami_id

  associate_public_ip_address = true

  # The size of instance to launch
  # type: string
  instance_type = "t2.micro"

  # Creates a unique name beginning with the specified prefix
  # type: string
  name = "cluster2"

  # A list of security group IDs to assign to the launch configuration
  # type: list(string)
  vpc_security_group_ids = [dependency.security-group_2.outputs.this_security_group_id]

  # A list of subnet IDs to launch resources in
  # type: list(string)
  subnet_ids = dependency.vpc.outputs.public_subnets

  user_data_base64 = <<EOT
IyEvYmluL2Jhc2gKZWNobyAiaW1wb3J0ZWQgZnJvbSBjbG91ZGluaXQncyB1c2VyZGF0YSIgPiAv
ZXRjL2dkLWRhdGEK
EOT


  key_name = dependency.keypair.outputs.this_key_pair_key_name
  private_key_location = "~/.ssh/terragrunt_rsa"
  remote-exec-user = "ubuntu"
  remote-exec-inline = [ "while ! curl -f https://kecomat.czipis.eu/poc.html; do sleep 5; done", ] 
}
