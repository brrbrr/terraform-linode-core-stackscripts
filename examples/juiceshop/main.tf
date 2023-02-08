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

module "juiceshop_linode_stackscripts" {
  source = "../../"
  token  = "xxxxxxxxxxxxxxxxxxxxxxxxx"

  stackscript_label       = "juiceshop-debian-deployment"
  stackscript_description = "Setup Docker + Run OWASP Juiceshop image."
  stackscript_script      = file("./juiceshop_stackscript.sh")
  stackscript_rev_note    = "Initial version"

  root_pass = random_string.root_pass.result
  
  image  = "linode/debian11"
  label  = "my-linode-juiceshop-TF"
  region = "eu-central"
  type   = "g6-standard-1"

  stackscript_data = {
    "ss_hostname"       = "juiceshop.example.com"
    "ss_username"       = "user1"
    "ss_password"       = "my-secure-password"
    "ss_pubkey"         = module.juiceshop_linode_stackscripts.linode_sshkey
  }
}


output "linode_ip" {
  description = "The public IP address for the Juiceshop Linode instance"
  value       = module.juiceshop_linode_stackscripts.linode_ip
}

output "linode_root_password" {
  description = "The password for the root user on the Juiceshop Linode instance"
  value       = module.juiceshop_linode_stackscripts.linode_root_password
}

output "linode_sshkey" {
  description = "The public sshkey for the Juiceshop Linode instance"
  value       = module.juiceshop_linode_stackscripts.linode_sshkey
}

output "linode_stackscript_id" {
  description = "The public sshkey for the Linode instance"
  value       = module.juiceshop_linode_stackscripts.linode_stackscript_id
}