# Deploy an OWASP Juiceshop docker container on Linode

This example illustrates how to deploy an OWASP Juiceshop docker container on a compute Linode instance using Terraform.

> OWASP Juice Shop is probably the most modern and sophisticated insecure web application! It can be used in security trainings, awareness demos, CTFs and as a guinea pig for security tools! Juice Shop encompasses vulnerabilities from the entire OWASP Top Ten along with many other security flaws found in real-world applications!

The [juiceshop_stackscript.sh](./juiceshop_stackscript.sh) StackScript is responsible for installing an OWASP Juiceshop docker container and exposing it on port 80. This staskcript allows to [secure your server](https://www.linode.com/docs/products/compute/compute-instances/guides/set-up-and-secure/) as per Linode guide.

# Usage

## main.tf

```hcl
module "juiceshop_linode_stackscripts" {
  source = "<module-path>"
  token  = "xxxxxxxxxxxxxxxxxxxxxxxxx"

  stackscript_label       = "juiceshop-debian-deployment"
  stackscript_description = "Setup Docker + Run OWASP Juiceshop image."
  stackscript_script      = file("./juiceshop_stackscript.sh")
  stackscript_rev_note    = "Initial version"

  root_pass = random_string.root_pass.result
  
  image  = "linode/debian11"
  label  = "my-linode-juiceshop-TF"
  region = "eu-central"
  type   = "g6-standard-1"

  stackscript_data = {
    "ss_hostname"       = "juiceshop.example.com"
    "ss_username"       = "user1"
    "ss_password"       = "my-secure-password"
    "ss_pubkey"         = module.juiceshop_linode_stackscripts.linode_sshkey
  }
}
}
```
Note: 
- the root password is auto generated via `random_string` resource.
- StackScripts support user defined data. A StackScript can use the UDF tag to create a variable whose value must be provided by the user of the script. This allows users to customize the behavior of a StackScript on a per-deployment basis. Any required UDF variable can be defined using the `stackscript_data` argument. In this case you will define the hostname to reach your juiceshop application, you define a new user and associated password to create on your Linode instance for security reason and you will specify the ssh public key to use for this user (we are using the same ssh key as per root user here).

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

3. In order to access your OWASP Juiceshop site, you need to create a domain and corresponding domain records for your site. 
    > If you are not familiar with the Domain Name System (DNS), review the [DNS Records: An Introduction](https://www.linode.com/docs/guides/dns-overview/) guide.

4. Navigate to your OWASP Juiceshop domain and verify that the site loads. You may have to wait a few minutes more after the `terraform apply` command returns, as the StackScript takes time to install the OWASP Juiceshop docker container. Additionally, it make take some time for your domain name changes to propagate.


### (Optionnal) Destroy
If you do not want to keep using the resources created by Terraform, run the `destroy` command from the terraform directory:
```bash
$ terraform destroy
```


## Prerequisite
Linode Terraform provider requires an API access token. Follow the [Getting Started with the Linode API guide](https://www.linode.com/docs/products/tools/api/get-started/#get-an-access-token) to obtain a token.

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->

<!-- END_AUTOMATED_TF_DOCS_BLOCK -->