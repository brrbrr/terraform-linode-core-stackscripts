# Akamai/Linode StackScripts Terraform CORE module

This module deploys a Linode instance based on a StackScript you define.
> StackScripts provide Linode users with the ability to automate the deployment of custom systems. They work by running a custom script when deploying a new Compute Instance. These custom scripts store tasks that you may need to repeat often on new Compute Instances.

This CORE module is based on [Create a Terraform Module Linode Guide](https://www.linode.com/docs/guides/create-terraform-module/) and include nested modules that split up the required resources between the root module, a `terraform-linode-instance` module which will be in charge of creating your Linode instance, and a `terraform-linode-stackscripts` module which will be in charge to create and modify your own Linode StackScript.

# Usage

## Run it as a standalone project

1. Clone the repository, using following command:

    ```bash
    > git clone https://github.com/brrbrr/terraform-linode-core-stackscripts.git
    > cd terraform-linode-core-stackscripts
    ```

2. Copy sample `terraform.tfvars.sample` into `terraform.tfvars` and provide values for all input variables defined in variables.tf file.

3. Run `terraform init` to download required providers and modules.
4. Run `terraform plan` to see the infrastructure plan
5. Run `terraform apply` to apply the Terraform configuration and create required infrastructure.

_**Note:** Run `terraform destroy` when you don't need these resources._
## Run it as a Terraform module

This way allows integration with your existing Terraform configurations.
Basic usage of this module is as follows:

```hcl
module "example" {
	source  = "./terraform-linode-core-stackscripts"
    
    # Required variables
	token       = "<token_id>"
	root_pass   = 

	# Optional variables
	image                       = "linode/debian11"
	key                         = "~/.ssh/id_rsa.pub"
	key_label                   = "my-ssh-key"
	label                       = "default-linode"
	region                      = "eu-central"
	stackscript_data            = {}
	stackscript_description     = "StackScript created via Terraform"
	stackscript_label           = "Terraform stackscript label"
	stackscript_rev_note        = "Initial version"
	stackscript_script          = "#!/bin/bash\necho 'Hello World'\n"
	type                        = "g6-standard-1"

}
```

## Example

- [juiceshop](./examples/juiceshop) - This example illustrates how to deploy an OWASP Juiceshop docker container on a compute Linode instance using Terraform.
- [wordpress](./examples/wordpress) - This example illustrates how to deploy a WordPress Site on a compute Linode instance using Terraform.
- [flexorigin](./examples/flexorigin) - This example illustrates how to deploy a Flexible Origin on a compute Linode instance using Terraform.

## Prerequisite
Linode Terraform provider requires an API access token. Follow the [Getting Started with the Linode API guide](https://www.linode.com/docs/products/tools/api/get-started/#get-an-access-token) to obtain a token.


<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

No providers.

## Resources

No resources.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_linode"></a> [linode](#module\_linode) | ./modules/terraform-linode-instance | n/a |
| <a name="module_stackscripts"></a> [stackscripts](#module\_stackscripts) | ./modules/terraform-linode-stackscripts | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_root_pass"></a> [root\_pass](#input\_root\_pass) | The initial password for the root user account. Changing root\_pass forces the creation of a new Linode Instance. If omitted, a random password will be generated but will not be stored in Terraform state. | `any` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | Linode API token | `any` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Image to use for Linode instance. | `string` | `"linode/debian11"` | no |
| <a name="input_key"></a> [key](#input\_key) | Public SSH Key's path to deploy for the root user on the newly created Linode. | `string` | `"~/.ssh/id_rsa.pub"` | no |
| <a name="input_key_label"></a> [key\_label](#input\_key\_label) | New SSH key label. | `string` | `"my-ssh-key"` | no |
| <a name="input_label"></a> [label](#input\_label) | The Linode's label is for display purposes only, but must be unique. | `string` | `"default-linode"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where your Linode will be located. Examples are us-east, us-west, ap-south | `string` | `"eu-central"` | no |
| <a name="input_stackscript_data"></a> [stackscript\_data](#input\_stackscript\_data) | An object containing responses to any User Defined Fields present in the StackScript being deployed to this Linode. Only accepted if 'stackscript\_id' is given. The required values depend on the StackScript being deployed. | `map(string)` | `{}` | no |
| <a name="input_stackscript_description"></a> [stackscript\_description](#input\_stackscript\_description) | A description for the StackScript. | `string` | `"StackScript created via Terraform"` | no |
| <a name="input_stackscript_label"></a> [stackscript\_label](#input\_stackscript\_label) | The StackScript's label is for display purposes only. | `string` | `"Terraform stackscript label"` | no |
| <a name="input_stackscript_rev_note"></a> [stackscript\_rev\_note](#input\_stackscript\_rev\_note) | This field allows you to add notes for the set of revisions made to this StackScript. | `string` | `"Initial version"` | no |
| <a name="input_stackscript_script"></a> [stackscript\_script](#input\_stackscript\_script) | The script to execute when provisioning a new Linode with this StackScript. | `string` | `"#!/bin/bash\necho 'Hello World'\n"` | no |
| <a name="input_type"></a> [type](#input\_type) | The Linode type defines the pricing, CPU, disk, and RAM specs of the instance. Examples are g6-nanode-1, g6-standard-2, g6-highmem-16, g6-dedicated-16 | `string` | `"g6-standard-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linode_ip"></a> [linode\_ip](#output\_linode\_ip) | The public IP address for the Linode instance |
| <a name="output_linode_root_password"></a> [linode\_root\_password](#output\_linode\_root\_password) | The password for the root user on the Linode instance |
| <a name="output_linode_sshkey"></a> [linode\_sshkey](#output\_linode\_sshkey) | The public sshkey for the Linode instance |
| <a name="output_linode_stackscript_id"></a> [linode\_stackscript\_id](#output\_linode\_stackscript\_id) | The public sshkey for the Linode instance |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
# Contributing
  
We're happy to accept help from fellow code-monkeys.
Use issues section to track ideas, feedback, tasks, or bugs.
Refer to the [contribution guidelines](./contributing.md) for information on contributing to this project.
# Authors

![@Benjamin Brouard](https://img.shields.io/badge/Benjamin%20Brouard-Security%20Professional%20Services%20%40%20Akamai-blue?logo=akamai&link=https://git.source.akamai.com/users/bbrouard/)
  
# License

[Apache License 2](https://choosealicense.com/licenses/apache-2.0/). See [LICENSE](./LICENSE.md) for full details.

-----------------

![Made with love](https://img.shields.io/badge/Made%20with%20%E2%9D%A4%EF%B8%8F-in%20France-EF4135?labelColor=0055A4)