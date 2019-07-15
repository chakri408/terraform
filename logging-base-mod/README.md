# svc-logging-base-mod

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| application\_id | Application ID | string | `"em-sre"` | no |
| asg\_tags | Resource tag map | list | `<list>` | no |
| avail\_zones | List of availability zones | list | `<list>` | no |
| aws\_account\_name | Aws account id | string | n/a | yes |
| create\_ec2 |  | string | `"1"` | no |
| create\_lambda |  | string | `"1"` | no |
| environment | Environment Name | string | `"prod"` | no |
| instance\_count | Instance Count | string | `"1"` | no |
| instance\_ebs\_optimized |  | string | `"false"` | no |
| instance\_type | Instance Type | string | `"t2.small"` | no |
| lambda\_name |  | string | `"svc-cloudwatch-splunk"` | no |
| lambda\_runtime |  | string | `"nodejs6.10"` | no |
| lambda\_timeout |  | string | `"60"` | no |
| region | AWS region | string | `"us-west-2"` | no |
| splunk\_function\_file |  | string | `"svc-cloudwatchlogs-splunk.zip"` | no |
| splunk\_source\_type |  | string | n/a | yes |
| splunk\_token |  | string | `"GetOneFromSRE"` | no |
| splunk\_url |  | string | `"https://splunkeventcollector.svc-1048.com/services/collector/event"` | no |
| stack | Stack Name | string | `"prod1"` | no |
| tags | Resource tag map | map | `<map>` | no |
