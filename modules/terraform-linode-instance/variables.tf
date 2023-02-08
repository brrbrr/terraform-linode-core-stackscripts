variable "root_pass" {
  description = "The initial password for the root user account. Changing root_pass forces the creation of a new Linode Instance. If omitted, a random password will be generated but will not be stored in Terraform state."
}

variable "private_ip" {
  description = "Whether or not you want a private ip address for your instance"
  default     = false
}

variable "backups_enabled" {
  description = "Whether or not to enable backups"
  default     = false
}

variable "region" {
  description = "The region where your Linode will be located. Examples are us-east, us-west, ap-south, eu-central"
}

variable "image" {
  description = "The Linux image to use"
}

variable "label" {
  description = "Optional label to display for the instance"
}

variable "tags" {
  description = "An optional list of tags"
  type        = list(string)
  default     = []
}

variable "type" {
  description = "The Linode type defines the pricing, CPU, disk, and RAM specs of the instance. Examples are g6-nanode-1, g6-standard-2, g6-highmem-16, g6-dedicated-16"
}

variable "key" {
  description = "Public SSH Key's path to deploy for the root user on the newly created Linode."
}

variable "key_label" {
  description = "New SSH key label"
}

variable "authorized_users" {
  description = "Your authorized users"
  type        = list(string)
  default     = []
}

variable "stackscript_id" {
  description = "The ID of the StackScript you want to use"
}

variable "stackscript_data" {
  description = "An object containing responses to any User Defined Fields present in the StackScript being deployed to this Linode. Only accepted if 'stackscript_id' is given. The required values depend on the StackScript being deployed. "
  type        = map(string)
}