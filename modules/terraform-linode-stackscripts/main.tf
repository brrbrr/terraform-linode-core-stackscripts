resource "linode_stackscript" "default" {
  label       = var.stackscript_label
  description = var.stackscript_description
  script      = var.stackscript_script
  images      = var.stackscript_images
  rev_note    = var.stackscript_rev_note
}