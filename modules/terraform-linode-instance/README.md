# Akamai/Linode Instance Terraform module

This module deploys a Linode instance.

# Usage

Basic usage of this module is as follows:

```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
	 image  			= 
	 key  				= 
	 key_label  		= 
	 label  			= 
	 region  			= 
	 root_pass  		= 
	 stackscript_data  	= 
	 stackscript_id  	= 
	 type  				= 

	 # Optional variables
	 authorized_users  	= []
	 backups_enabled  	= false
	 private_ip  		= false
	 tags  				= []
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
| [linode_instance.linode_id](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance) | resource |
| [linode_sshkey.main_key](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/sshkey) | resource |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image"></a> [image](#input\_image) | The Linux image to use | `any` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | Public SSH Key's path to deploy for the root user on the newly created Linode. | `any` | n/a | yes |
| <a name="input_key_label"></a> [key\_label](#input\_key\_label) | New SSH key label | `any` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | Optional label to display for the instance | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where your Linode will be located. Examples are us-east, us-west, ap-south, eu-central | `any` | n/a | yes |
| <a name="input_root_pass"></a> [root\_pass](#input\_root\_pass) | The initial password for the root user account. Changing root\_pass forces the creation of a new Linode Instance. If omitted, a random password will be generated but will not be stored in Terraform state. | `any` | n/a | yes |
| <a name="input_stackscript_data"></a> [stackscript\_data](#input\_stackscript\_data) | An object containing responses to any User Defined Fields present in the StackScript being deployed to this Linode. Only accepted if 'stackscript\_id' is given. The required values depend on the StackScript being deployed. | `map(string)` | n/a | yes |
| <a name="input_stackscript_id"></a> [stackscript\_id](#input\_stackscript\_id) | The ID of the StackScript you want to use | `any` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | The Linode type defines the pricing, CPU, disk, and RAM specs of the instance. Examples are g6-nanode-1, g6-standard-2, g6-highmem-16, g6-dedicated-16 | `any` | n/a | yes |
| <a name="input_authorized_users"></a> [authorized\_users](#input\_authorized\_users) | Your authorized users | `list(string)` | `[]` | no |
| <a name="input_backups_enabled"></a> [backups\_enabled](#input\_backups\_enabled) | Whether or not to enable backups | `bool` | `false` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Whether or not you want a private ip address for your instance | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An optional list of tags | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | The public IP address for the Linode instance |
| <a name="output_root_password"></a> [root\_password](#output\_root\_password) | The password for the root user on the Linode instance |
| <a name="output_sshkey_linode"></a> [sshkey\_linode](#output\_sshkey\_linode) | SSH public key |

# Contributing

We're happy to accept help from fellow code-monkeys.
Report issues/questions/feature requests on in the [issues](https://github.com/brrbrr/terraform-akamai-core-new-security-configuration/issues) section.
Refer to the [contribution guidelines](./contributing.md) for information on contributing to this module.

# Authors

- [@Benjamin Brouard](https://www.github.com/brrbrr), Security Professional Services @Akamai.

# License

[Apache License 2](https://choosealicense.com/licenses/apache-2.0/). See [LICENSE](./LICENSE.md) for full details.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->