variable "stackscript_label" {
  description = "The StackScript's label is for display purposes only."
  default     = "Default-label"
}

variable "stackscript_description" {
  description = "A description for the StackScript."
}

variable "stackscript_script" {
  description = "The script to execute when provisioning a new Linode with this StackScript."
}

variable "stackscript_images" {
  description = "A list of Image IDs representing the Images that this StackScript is compatible for deploying with."
  type        = list(string)
}

variable "stackscript_rev_note" {
  description = "This field allows you to add notes for the set of revisions made to this StackScript."
}