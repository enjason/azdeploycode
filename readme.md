README
===

* Terraform: `v0.11.14`
* Terragrunt: `v0.18.6`

## Provisioning

### Pre-requisites

1. Install [Terraform](https://www.terraform.io/) and [Terragrunt](https://github.com/gruntwork-io/terragrunt).
2. Make sure Blob container exists. We use [Azure blob as a Terraform backend](https://www.terraform.io/docs/backends/types/azurerm.html)
3. Configure Azure credentials via environment variables.

Set following environment variables before running `terragrunt` command.

```
# Export environment variables to connect to Azure
export ARM_SUBSCRIPTION_ID="*****"
export ARM_CLIENT_ID="*****"
export ARM_CLIENT_SECRET="*****"
export ARM_TENANT_ID="*****"
# Export environment variables to connect Blob to store tfstate files
export BLOB_ACCESS_KEY="*****"
```

### Deploying a single module

1. `cd` into the module's folder (e.g. AZCLOUD\parameters\mysql).
2. Run `terragrunt plan` to see the changes you're about to apply.
3. If the plan looks good, run `terragrunt apply`.

### Deploying all modules in an environment

1. `cd` into the environment's folder (e.g. AZCLOUD\parameters).
2. Run `terragrunt plan-all` to see the changes you're about to apply.
3. If the plan looks good, run `terragrunt apply-all`.


## How is the code in this repo organized

We uses Terragrunt to wrap Terraform.


## Deploying Orders

0. apply certifications and domains
1. Virtual Network
2. Storage Accounts
3. Virtual Machines
4. Public IP
5. Application Gateway
6. Load Balaner
7. Traffic Manager
8. Redis
9. MySQL
10. SQL
11. Postgresql
12. Logic_apps
13. Container_registry
14. HDInsight
15. Data factory
16. Log Analytics workspace

