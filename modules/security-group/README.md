# Terraform AWS Security Group Module

This Terraform module creates an AWS Security Group with customizable settings, including project tagging, environment naming, and optional VPC selection.

---

## Input Variables

### 🔹 Required

| Name            | Type   | Description                          |
|-----------------|--------|--------------------------------------|
| `sg_name`       | string | Name of the Security Group           |
| `sg_description`| string | Description of the Security Group    |
| `project`       | string | Project name (used for tagging)      |
| `environment`   | string | Environment name (used for tagging)  |

---

### Optional

| Name               | Type        | Default | Description                                           |
|--------------------|-------------|---------|-------------------------------------------------------|
| `use_default_vpc`  | `bool`      | `false` | Whether to use the default VPC                        |
| `vpc_id`           | `string`    | `""`    | Custom VPC ID. Required if `use_default_vpc = false`  |
| `sg_tags`          | `map(any)`  | `{}`    | Additional tags to apply to the Security Group        |

---

## Outputs

| Name            | Description                  |
|-----------------|------------------------------|
| `security_group_id` | The ID of the created Security Group |

---

##  Security Group Rules

- **Egress**: All outbound traffic is **allowed by default**.

---

##  Example Usage

```hcl
module "security_group" {
  source         = "./modules/security-group"

  sg_name        = "my-sg"
  sg_description = "Security group for my app"
  project        = "myproject"
  environment    = "dev"

  use_default_vpc = false
  vpc_id          = "vpc-0abc1234def56789a"

  sg_tags = {
    component = "backend",
    created = "royal-1158",
    maintained = "devops-team"
  }
}
