output "linode_ip" {
  description = "The public IP address for the Linode instance"
  value       = module.linode.instance_ip
}

output "linode_root_password" {
  description = "The password for the root user on the Linode instance"
  value       = module.linode.root_password
}

output "linode_sshkey" {
  description = "The public sshkey for the Linode instance"
  value       = module.linode.sshkey_linode
}

output "linode_stackscript_id" {
  description = "The public sshkey for the Linode instance"
  value       = module.stackscripts.stackscript_id
}
