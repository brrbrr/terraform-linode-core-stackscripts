variable "token" {
  description = " Linode API token"
}

variable "key" {
  description = "Public SSH Key's path to deploy for the root user on the newly created Linode."
  default     = "~/.ssh/id_rsa.pub"
}

variable "key_label" {
  description = "New SSH key label."
  default     = "my-ssh-key"
}

variable "root_pass" {
  description = "The initial password for the root user account. Changing root_pass forces the creation of a new Linode Instance. If omitted, a random password will be generated but will not be stored in Terraform state."
}

variable "stackscript_label" {
  description = "The StackScript's label is for display purposes only."
  default     = "Terraform stackscript label"
}

variable "stackscript_description" {
  description = "A description for the StackScript."
  default     = "StackScript created via Terraform"
}

variable "stackscript_script" {
  description = "The script to execute when provisioning a new Linode with this StackScript."
  default     = <<EOF
#!/bin/bash
echo 'Hello World'
EOF
}

variable "stackscript_rev_note" {
  description = "This field allows you to add notes for the set of revisions made to this StackScript."
  default     = "Initial version"
}

variable "stackscript_data" {
  description = "An object containing responses to any User Defined Fields present in the StackScript being deployed to this Linode. Only accepted if 'stackscript_id' is given. The required values depend on the StackScript being deployed. "
  type        = map(string)
  default     = {}
}


variable "image" {
  description = "Image to use for Linode instance."
  default     = "linode/debian11"
}

variable "label" {
  description = "The Linode's label is for display purposes only, but must be unique."
  default     = "default-linode"
}

variable "region" {
  description = "The region where your Linode will be located. Examples are us-east, us-west, ap-south, eu-central"
  default     = "eu-central"
}

variable "type" {
  description = "The Linode type defines the pricing, CPU, disk, and RAM specs of the instance. Examples are g6-nanode-1, g6-standard-2, g6-highmem-16, g6-dedicated-16"
  default     = "g6-standard-1"
}