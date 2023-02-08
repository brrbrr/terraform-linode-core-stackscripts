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

module "wordpress_linode_stackscripts" {
  source = "../../"
  token  = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

  stackscript_label       = "wordpress-ubuntu-deployment"
  stackscript_description = "Wordpress on Ubunutu 20.04"
  stackscript_script      = file("./wordpress_stackscript.sh")
  stackscript_rev_note    = "Initial version"


  root_pass = random_string.root_pass.result

  image  = "linode/ubuntu20.04"
  label  = "my-linode-wordpress-TF"
  region = "eu-central"
  type   = "g6-standard-1"

  stackscript_data = {
    "ssuser"          = "username"
    "sspassword"      = "my-secure-password"
    "hostname"        = "wordpress"
    "website"         = "example.com"
    "db_password"     = "another-secure-password"
    "dbuser"          = "wpuser"
    "dbuser_password" = "a-third-secure-password"
  }
}


output "linode_ip" {
  description = "The public IP address for the Juiceshop Linode instance"
  value       = module.wordpress_linode_stackscripts.linode_ip
}

output "linode_root_password" {
  description = "The password for the root user on the Juiceshop Linode instance"
  value       = module.wordpress_linode_stackscripts.linode_root_password
}

output "linode_sshkey" {
  description = "The public sshkey for the Juiceshop Linode instance"
  value       = module.wordpress_linode_stackscripts.linode_sshkey
}

output "linode_stackscript_id" {
  description = "The public sshkey for the Linode instance"
  value       = module.wordpress_linode_stackscripts.linode_stackscript_id
}