# Tags terraform module

A terraform module to create standard tags to be used across all other modules.

## Module usage:
```hcl
module "tags" {
  source      = "./modules/tags"
  name        = "dmz"
  customer    = "Fiserv"
  environment = "dev"
}
```

The output of the module is intended to be used as a list of tags to be applied to other modules.

## Advanced usage

The module can be used recursively to build on previous instances. For example:

```hcl
module "common" {
  source      = "./modules/tags"
  customer    = "Fiserv"
  environment = "dev"
} # this will generate an id=`Fiserv-dev`

module "dmz_tags" {
  source = "./modules/tags"
  name   = "dmz"
  tags   = module.common.tags
} # this will generate an id=`Fiserv-dev-dmz`
```
And the `dmz_tags` module will keep the common tags but will add its own local name to it:
```
"tags" = {
  "Customer" = "Fiserv"
  "Environment" = "dev"
  "Name" = "Fiserv-DEV-DMZ"
  "Terraform_workspace" = "default"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| customer | Customer name (e.g. `Fiserv`, `fis`, etc.). | `string` | `""` | no |
| delimiter | Delimiter to be used between `name`, `environment`, etc. | `string` | `"-"` | no |
| environment | Environment (e.g. `prod`, `dev`, `uat`). | `string` | `""` | no |
| name | Name  (e.g. `bastion`, `dmz`, etc.). | `string` | `""` | no |
| order | Order vars for id, e.g. `name`,`environment`, etc. | `list` | <pre>[<br>  "customer",<br>  "environment",<br>  "name"<br>]</pre> | no |
| tags | Additional tags (e.g. map(`Team`,`DevOps`). | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Name id to be applied to resources |
| tags | Tags as a map (includes a `Name` tag) |
| tags\_as\_list\_of\_maps | Tags as a list of maps (includes a `Name` tag) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
