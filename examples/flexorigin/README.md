# Deploy a Flexible Origin (FO) on Linode

This example illustrates how to deploy a Flexible Origin on a compute Linode instance using Terraform.

> Flexible Origin (FO) is a web server that can be controlled using request headers. Those headers are called X-FO headers.

The [flexible_stackscript.sh](./flexible_stackscript.sh) StackScript is responsible for installing a flexible origin.
This stackscript is based on worked done by [@rafaalpizar](https://github.com/rafaalpizar) in following repo : https://github.com/rafaalpizar/flexible-origin-install

# Usage

## main.tf

```hcl
module "flexorigin_linode_stackscripts" {
  source = "<module-path>"
  token  = "xxxxxxxxxxxxxxxxxxxxxxxxx"

  stackscript_label       = "flexorigin-ubuntu-deployment"
  stackscript_description = "Flexorigin on Ubuntu"
  stackscript_script      = data.http.flexorigin_stackscript.response_body
  stackscript_rev_note    = "Initial version"

  root_pass = random_string.root_pass.result
  
  image  = "linode/ubuntu20.04"
  label  = "my-linode-flexorigin-TF"
  region = "eu-central"
  type   = "g6-standard-1"
}

```
Note: 
- the root password is auto generated via `random_string` resource.


## Initialize, Plan, and Apply the Terraform Configuration

### Initialize

Whenever a new provider is used in a Terraform configuration, it must be initialized before you can create resources with it. The initialization process downloads and installs the provider’s plugin and performs any other steps needed to prepare for its use.

Navigate to your terraform directory in your terminal and run:
```bash
$ terraform init
```
You will see a message that confirms that the Linode provider plugins have been successfully initialized.

### Plan

It can be useful to view your configuration’s execution plan before actually committing those changes to your infrastructure. Terraform includes a `plan` command for this purpose. Run this command from the terraform directory:
```bash
$ terraform plan
```
`plan` won’t take any actions or make any changes on your Linode account. Instead, an analysis is done to determine which actions (i.e. Linode resource creations, deletions, or modifications) are required to achieve the state described in your configuration.

### Apply
You are now ready to create the infrastructure defined in your `main.tf` configuration file:

1. Navigate to your terraform directory in your terminal and run:
```bash
$ terraform apply
```
2. Terraform will begin to create the resources you’ve defined. This process will take several minutes to complete. 

3. Navigate to your Flexible Origin via the Linode IP instance created and verify that the site loads. You may have to wait a few minutes more after the `terraform apply` command returns, as the StackScript takes time to install the Flexible origin. Additionally, it make take some time for your domain name changes to propagate.


### (Optionnal) Destroy
If you do not want to keep using the resources created by Terraform, run the `destroy` command from the terraform directory:
```bash
$ terraform destroy
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
| <a name="provider_http"></a> [http](#provider\_http) | 3.2.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Resources

| Name | Type |
|------|------|
| [random_string.root_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [http_http.flexorigin_stackscript](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_flexorigin_linode_stackscripts"></a> [flexorigin\_linode\_stackscripts](#module\_flexorigin\_linode\_stackscripts) | ../../ | n/a |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linode_ip"></a> [linode\_ip](#output\_linode\_ip) | The public IP address for the flexorigin Linode instance |
| <a name="output_linode_root_password"></a> [linode\_root\_password](#output\_linode\_root\_password) | The password for the root user on the flexorigin Linode instance |
| <a name="output_linode_sshkey"></a> [linode\_sshkey](#output\_linode\_sshkey) | The public sshkey for the flexorigin Linode instance |
| <a name="output_linode_stackscript_id"></a> [linode\_stackscript\_id](#output\_linode\_stackscript\_id) | The public sshkey for the Linode instance |

<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
# Contributing
  
We're happy to accept help from fellow code-monkeys.
Use issues section to track ideas, feedback, tasks, or bugs.
Refer to the [contribution guidelines](./contributing.md) for information on contributing to this project.
# Authors

![@Benjamin Brouard](https://img.shields.io/badge/Benjamin%20Brouard-Security%20Professional%20Services%20%40%20Akamai-blue?logo=akamai&link=https://git.source.akamai.com/users/bbrouard/)
> The flexible origin stackscript is based on worked done by [@rafaalpizar](https://github.com/rafaalpizar) in following repo : https://github.com/rafaalpizar/flexible-origin-install
  
# License

[Apache License 2](https://choosealicense.com/licenses/apache-2.0/). See [LICENSE](./LICENSE.md) for full details.

-----------------

![Made with love](https://img.shields.io/badge/Made%20with%20%E2%9D%A4%EF%B8%8F-in%20France-EF4135?labelColor=0055A4)