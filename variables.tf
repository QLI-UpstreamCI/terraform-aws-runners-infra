variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "lambda_version" {
  description = "Lambda version you want to download from GitHub packages (tied to GH tags)"
  type        = string
  default     = "v6.4.2"
}

variable "resource_name_prefix" {
  description = "prefix for naming the created resources"
  type        = string
}

variable "vpc_name" {
  description = "VPC that will host your runners and infrastructure"
  type        = string
}

variable "lambda_vpc_name" {
  description = "VPC that will be attached to your deployment's lambda functions (if not provided the vpc_name var will be used), for it to take effect you also need to provide the lambda_subnet_names variable"
  type        = string
  default     = ""
}

variable "subnet_names" {
  description = "List of subnet names to deploy the runners in"
  type        = set(string)
}

variable "lambda_subnet_names" {
  description = "List of subnet names to deploy the lambda functions in (only if you want to attach the lambda functions to a VPC)"
  type        = list(string)
  default     = []
}

variable "gh_app_pem_secret_name" {
  type        = string
  description = "Name of the secret that stores the content of the GitHub App Private Key"
}

variable "github_app_app_id" {
  type        = string
  description = "App ID provided by the GitHub App you created"
  sensitive   = true
}

variable "multi_runner_config" {
  type        = any
  description = <<EOT
    This is where the magic appears!, you specify all your runners' settings through this variable.
    E.g. instance type, OS, runners count...
    We decided to keep this variable type simple and dynamic for compatibility with future versions
    but if you want to see all possible options. constrains, and defaults, 
    refer to this page https://github.com/philips-labs/terraform-aws-github-runner/blob/main/modules/multi-runner/variables.tf
    and find the variable "multi_runner_config".
  EOT
}

variable "role_path" {
  description = "The path that will be added to role path for created roles, if not set the environment name will be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "Default tags"
  type        = map(string)
  default     = {}
}

variable "policies_per_runner" {
  description = "Map containing a set of policies, where key: policy name, value: tf object with the policy and the runner type"
  type = map(object({
    runner_key = string,
    policy     = string
  }))
  default = {}
}

variable "tracing_config" {
  description = "Map that enables x-ray tracing for all lambda functions (disabled by default)"
  type = object({
    mode                  = optional(string, null)
    capture_http_requests = optional(bool, false)
    capture_error         = optional(bool, false)
  })
  default = {}
}

#EFS related 
variable "token_name" {
  description = "Name for the EFS Token"
  type        = string
  default = "qipl-auidoreach-gh-efs"
}

variable "performance_mode" {
  description = "EFS Performance Mode"
  type        = string
  default     = "generalPurpose"
}

variable "throughput_mode" {
  description = "EFS Throughput Mode"
  type        = string
  default     = "elastic"
}

variable "environment" {
  description = "Deployment environment (dev, stage, prod)"
  type        = string
  default     = "dev"
}

variable "logging_retention_in_days" {
  description = "Specifies the number of days you want to retain log events for the lambda log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
  type        = number
  default     = 30
}

variable "s3_artifacts_expiration" {
  description = "prefix for naming the s3 artifacts lifecycle"
  type        = number
}

variable "log_level" {
  description = "Logging level for lambda logging. Valid values are  'silly', 'trace', 'debug', 'info', 'warn', 'error', 'fatal'."
  type        = string
  default     = "debug"
  validation {
    condition = anytrue([
      var.log_level == "silly",
      var.log_level == "trace",
      var.log_level == "debug",
      var.log_level == "info",
      var.log_level == "warn",
      var.log_level == "error",
      var.log_level == "fatal",
    ])
    error_message = "`log_level` value not valid. Valid values are 'silly', 'trace', 'debug', 'info', 'warn', 'error', 'fatal'."
  }
}