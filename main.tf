provider "linode" {
  token = var.token
}

module "stackscripts" {
  source                  = "./modules/terraform-linode-stackscripts"
  stackscript_label       = var.stackscript_label
  stackscript_description = var.stackscript_description
  stackscript_script      = var.stackscript_script
  stackscript_images      = [var.image]
  stackscript_rev_note    = var.stackscript_rev_note
}

module "linode" {
  source = "./modules/terraform-linode-instance"

  key              = var.key
  key_label        = var.key_label
  image            = var.image
  label            = var.label
  region           = var.region
  type             = var.type
  root_pass        = var.root_pass
  stackscript_id   = module.stackscripts.stackscript_id
  stackscript_data = var.stackscript_data
}