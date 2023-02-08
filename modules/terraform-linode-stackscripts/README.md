# Akamai/Linode StackScripts Terraform module

This module is in charge to create and modify your own Linode [StackScript](https://www.linode.com/docs/products/tools/stackscripts/). 

> StackScripts provide Linode users with the ability to automate the deployment of custom systems. They work by running a custom script when deploying a new Compute Instance. These custom scripts store tasks that you may need to repeat often on new Compute Instances.


# Usage

Basic usage of this module is as follows:

```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
	 stackscript_description  	= 
	 stackscript_images  		= 
	 stackscript_rev_note  		= 
	 stackscript_script  		= 

	 # Optional variables
	 stackscript_label  		= "Default-label"
}
```

## Prerequisite
Linode Terraform provider requires an API access token. Follow the [Getting Started with the Linode API guide](https://www.linode.com/docs/products/tools/api/get-started/#get-an-access-token) to obtain a token.


<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | n/a |

## Resources

| Name | Type |
|------|------|
| [linode_stackscript.default](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/stackscript) | resource |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_stackscript_description"></a> [stackscript\_description](#input\_stackscript\_description) | A description for the StackScript. | `any` | n/a | yes |
| <a name="input_stackscript_images"></a> [stackscript\_images](#input\_stackscript\_images) | A list of Image IDs representing the Images that this StackScript is compatible for deploying with. | `list(string)` | n/a | yes |
| <a name="input_stackscript_rev_note"></a> [stackscript\_rev\_note](#input\_stackscript\_rev\_note) | This field allows you to add notes for the set of revisions made to this StackScript. | `any` | n/a | yes |
| <a name="input_stackscript_script"></a> [stackscript\_script](#input\_stackscript\_script) | The script to execute when provisioning a new Linode with this StackScript. | `any` | n/a | yes |
| <a name="input_stackscript_label"></a> [stackscript\_label](#input\_stackscript\_label) | The StackScript's label is for display purposes only. | `string` | `"Default-label"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_stackscript_id"></a> [stackscript\_id](#output\_stackscript\_id) | n/a |

# Contributing

We're happy to accept help from fellow code-monkeys.
Report issues/questions/feature requests on in the [issues](https://github.com/brrbrr/terraform-akamai-core-new-security-configuration/issues) section.
Refer to the [contribution guidelines](./contributing.md) for information on contributing to this module.

# Authors

- [@Benjamin Brouard](https://www.github.com/brrbrr), Security Professional Services @Akamai.

# License

[Apache License 2](https://choosealicense.com/licenses/apache-2.0/). See [LICENSE](./LICENSE.md) for full details.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->