<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.secretmasterECS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.sversion3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_uuid.test](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cs_dns_name"></a> [cs\_dns\_name](#input\_cs\_dns\_name) | cs\_dns\_name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the env | `string` | n/a | yes |
| <a name="input_gs_dns_name"></a> [gs\_dns\_name](#input\_gs\_dns\_name) | gs\_dns\_name | `string` | n/a | yes |
| <a name="input_gs_private"></a> [gs\_private](#input\_gs\_private) | gs\_private | `string` | n/a | yes |
| <a name="input_gs_public"></a> [gs\_public](#input\_gs\_public) | gs\_public | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the VPC | `string` | n/a | yes |
| <a name="input_ner_dns_name"></a> [ner\_dns\_name](#input\_ner\_dns\_name) | ner\_dns\_name | `string` | n/a | yes |
| <a name="input_ner_private"></a> [ner\_private](#input\_ner\_private) | ner\_private | `string` | n/a | yes |
| <a name="input_ner_public"></a> [ner\_public](#input\_ner\_public) | ner\_public | `string` | n/a | yes |
| <a name="input_tc_dns_name"></a> [tc\_dns\_name](#input\_tc\_dns\_name) | tc\_dns\_name | `string` | n/a | yes |
| <a name="input_tc_private"></a> [tc\_private](#input\_tc\_private) | tc\_private | `string` | n/a | yes |
| <a name="input_tc_public"></a> [tc\_public](#input\_tc\_public) | tc\_public | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->