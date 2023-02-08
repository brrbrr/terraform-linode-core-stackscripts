locals {
  key = var.key
}

resource "linode_sshkey" "main_key" {
  label   = var.key_label
  ssh_key = chomp(file(local.key))
}

resource "linode_instance" "linode_id" {
  image  = var.image
  label  = var.label
  region = var.region
  type   = var.type
  tags   = var.tags

  authorized_keys = [linode_sshkey.main_key.ssh_key]
  root_pass       = var.root_pass

  authorized_users = var.authorized_users
  private_ip       = var.private_ip
  backups_enabled  = var.backups_enabled

  stackscript_id   = var.stackscript_id
  stackscript_data = var.stackscript_data
}