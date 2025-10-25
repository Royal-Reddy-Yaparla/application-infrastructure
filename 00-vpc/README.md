# Terraform Multi-Environment Setup using Workspaces

This guide explains how to use Terraform workspaces to manage multiple environments (`dev`, `qa`, `prod`) for your VPC setup.

---

## Overview

The Terraform configuration uses a `locals` block and a reusable VPC module:

- `locals.environment` – maps workspaces to environment names.
- `locals.cidr_block` – VPC CIDR blocks per environment.
- `locals.public_cidr_block` – Public subnet CIDR blocks per environment.
- `locals.private_cidr_block` – Private subnet CIDR blocks per environment.
- `locals.database_cidr_block` – Database subnet CIDR blocks per environment.

The module `vpc` dynamically picks the CIDR blocks and environment based on the current Terraform workspace:

```hcl
module "vpc" {
  source              = "../../modules/VPC"
  environment         = local.environment[terraform.workspace]
  project             = var.project
  vpc_cidr_block      = local.cidr_block[terraform.workspace]
  public_cidr_block   = local.public_cidr_block[terraform.workspace]
  private_cidr_block  = local.private_cidr_block[terraform.workspace]
  database_cidr_block = local.database_cidr_block[terraform.workspace]
  is_peering_required = var.is_peering_required
}
````

---

## Terraform Workspace Commands

### 1. Create New Environments

Create a workspace for each environment:

```bash
terraform workspace new dev
terraform workspace new qa
terraform workspace new prod
```

### 2. Switch Between Environments

Select the workspace for the environment you want to work with:

```bash
terraform workspace select dev
terraform workspace select qa
terraform workspace select prod
```

### 3. List All Workspaces

Check all existing workspaces:

```bash
terraform workspace list
```

> Example:
>
> ```
>   default
> * dev
>   qa
>   prod
> ```

### 4. Show Current Workspace

Verify which workspace is active:

```bash
terraform workspace show
```

### 5. Delete a Workspace

Remove a workspace (not the current one):

```bash
terraform workspace delete <workspace-name>
```

> Example:
>
> ```bash
> terraform workspace delete qa
> ```

---

## Apply Terraform for a Specific Environment

1. Select the desired workspace:

```bash
terraform workspace select dev
```

2. Initialize Terraform (only once per new workspace):

```bash
terraform init
```

3. Plan changes:

```bash
terraform plan -var="project=my-project"
```

4. Apply changes:

```bash
terraform apply -var="project=my-project"
```

> ⚠️ **Note:** Terraform automatically picks the CIDR blocks and environment values based on the current workspace.

---

