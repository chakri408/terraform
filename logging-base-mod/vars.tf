# Environment

variable "create_ec2" {
  default = 1
}


variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}


variable "application_id" {
  description = "Application ID"
  default     = "svc-appd-ext"
}

variable "aws_account_name" {
  description = "Aws account id"
}

variable "environment" {
  description = "Environment Name"
#  default     = "prod"
}

variable "stack" {
  description = "Stack Name"
}


variable "avail_zones" {
  description = "List of availability zones"
  type        = "list"
  default     = ["us-west-2a"]
}

variable "instance_type" {
  description = "Instance Type"
  default     = "t2.small"
}

variable "instance_count" {
  description = "Instance Count"
  default     = "1"
}

variable "instance_ebs_optimized" {
  default = false
}

variable "tags" {
  description = "Resource tag map"
  type        = "map"

  default = {
    Application          = "AppDynamics Machine agent"
    ApplicationComponent = "svc monitoring"
    SupportOwner         = "svc"
    ApplicationOwner     = "svc"
    Lifecycle            = "Always On"
    Project              = "Prius"
    SreMonitor           = "True"
  }
}

#Lambda variables

variable "lambda_name" {
  default = "svc-cloudwatch-splunk"
}


variable "lambda_runtime" {
  default = "nodejs6.10"
}


variable "lambda_timeout" {
  default = "60"
}

variable "splunk_function_file" {
  default = "svcs-splunk.zip"
}

variable "splunk_token" {
  default = "GetOneFromsvc"
}

variable "splunk_url" {
  default = "https://splunkeventcollector.svc109899.com/services/collector/event"
}

variable "splunk_source_type" {
}

variable "create_lambda" {
  default = 1
}


#Tags for svc visibility
variable "asg_tags" {
  default = [
    {
      key                 = "ApplicationGroup"
      value               = "AppDynamics Machine agent"
      propagate_at_launch = true
    },
    {
      key                 = "ApplicationComponent"
      value               = "svc monitoring"
      propagate_at_launch = true
    },
    {
      key                 = "SupportOwner"
      value               = "svc"
      propagate_at_launch = true
    },
    {
      key                 = "LifeCycle"
      value               = "AlwaysOn"
      propagate_at_launch = true
    },
    {
      key                 = "SVCMonitor"
      value               = "True"
      propagate_at_launch = true
    },
  ]
}
