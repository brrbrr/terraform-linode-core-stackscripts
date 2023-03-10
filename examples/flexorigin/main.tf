terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
  # Constraint to specify which versions of Terraform can be used with this configuration.
  required_version = ">= 1.0.0"
}

resource "random_string" "root_pass" {
  length           = 32
  lower            = true
  upper            = true
  numeric          = true
  special          = true
  min_special      = "1"
}

data "http" "flexorigin_stackscript" {
  url = "https://raw.githubusercontent.com/rafaalpizar/flexible-origin-install/master/install_ubuntu.sh"
}

module "flexorigin_linode_stackscripts" {
  source = "../../"
  token  = "xxxxxxxxxxxxxxxxxxxxxxx"

  stackscript_label       = "flexorigin-ubuntu-deployment"
  stackscript_description = "Flexorigin on Ubuntu"
  stackscript_script      = data.http.flexorigin_stackscript.response_body
  stackscript_rev_note    = "Initial version"

  root_pass = random_string.root_pass.result
  
  image  = "linode/ubuntu20.04"
  label  = "my-linode-flexorigin-TF"
  region = "eu-central"
  type   = "g6-standard-1"
}

output "linode_ip" {
  description = "The public IP address for the flexorigin Linode instance"
  value       = module.flexorigin_linode_stackscripts.linode_ip
}

output "linode_root_password" {
  description = "The password for the root user on the flexorigin Linode instance"
  value       = module.flexorigin_linode_stackscripts.linode_root_password
}

output "linode_sshkey" {
  description = "The public sshkey for the flexorigin Linode instance"
  value       = module.flexorigin_linode_stackscripts.linode_sshkey
}

output "linode_stackscript_id" {
  description = "The public sshkey for the Linode instance"
  value       = module.flexorigin_linode_stackscripts.linode_stackscript_id
}