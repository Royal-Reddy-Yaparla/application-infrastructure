
# Terraform Workspaces Guide

This document explains how to manage Terraform workspaces for different environments such as `dev`, `qa`, and `prod`.

---

## What is a Terraform Workspace?

Terraform workspaces allow you to use the same configuration for multiple environments while keeping their state separate. Each workspace has its own state file.

---

## Workspace Commands

### 1. Create a New Workspace (Environment)

Use the `terraform workspace new` command to create a new environment:

```bash
# Create development environment
terraform workspace new dev

# Create QA environment
terraform workspace new qa

# Create production environment
terraform workspace new prod
````

### 2. Select a Workspace (Switch Environment)

To switch between workspaces:

```bash
# Switch to development environment
terraform workspace select dev

# Switch to QA environment
terraform workspace select qa

# Switch to production environment
terraform workspace select prod
```

### 3. List All Workspaces

To see all existing workspaces:

```bash
terraform workspace list
```

> Example output:
>
> ```
>   default
> * dev
>   qa
>   prod
> ```
>
> The `*` indicates the current active workspace.

### 4. Show Current Workspace

To see which workspace is currently active:

```bash
terraform workspace show
```

### 5. Delete a Workspace

To remove a workspace:

```bash
terraform workspace delete <workspace-name>
```

> Example:

```bash
terraform workspace delete qa
```

> ⚠️ **Note:** You cannot delete the currently selected workspace. Switch to another workspace before deleting.

---

## Best Practices

* Use separate workspaces for `dev`, `qa`, and `prod`.
* Always verify the current workspace using `terraform workspace show` before applying changes.
* Keep workspace naming consistent with environment names.

---
