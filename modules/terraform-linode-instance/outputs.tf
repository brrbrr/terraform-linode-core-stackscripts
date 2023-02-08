output "instance_ip" {
  description = "The public IP address for the Linode instance"
  value       = linode_instance.linode_id.ip_address
}

output "root_password" {
  description = "The password for the root user on the Linode instance"
  value       = var.root_pass
}

output "sshkey_linode" {
  description = "SSH public key"
  value       = linode_sshkey.main_key.ssh_key
}