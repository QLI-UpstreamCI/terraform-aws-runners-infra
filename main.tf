resource "random_id" "webhook_secret" {
  byte_length = 20
}
locals {
  lambdas = {
    "webhook" = {
      filename = "webhook.zip"
      tag      = var.lambda_version
    },
    "runners" = {
      filename = "runners.zip"
      tag      = var.lambda_version
    },
    "runner-binaries-syncer" = {
      filename = "runner-binaries-syncer.zip"
      tag      = var.lambda_version
    },
  }
}

module "github_runner" {
  # source     = "philips-labs/github-runner/aws//modules/multi-runner"
  source     = "github-aws-runners/github-runner/aws//modules/multi-runner"
  version    = "6.5.9"
  aws_region = var.aws_region
  vpc_id     = data.aws_vpc.vpc.id
  subnet_ids = data.aws_subnets.subnet.ids

  github_app = {
    key_base64     = base64encode(data.aws_secretsmanager_secret_version.github_app_pem.secret_string)
    id             = var.github_app_app_id
    webhook_secret = random_id.webhook_secret.hex
  }

  prefix              = var.resource_name_prefix
  multi_runner_config = var.multi_runner_config
  role_path           = var.role_path
  logging_retention_in_days = var.logging_retention_in_days
  log_level  = var.log_level
  
  # Lambda settings
  # Only send subnets in the lambda_subnet_names variable if the lambda functions will be attached to a VPC
  lambda_subnet_ids         = (length(var.lambda_subnet_names) != 0) ? data.aws_subnets.lambda_subnets.ids : []
  lambda_security_group_ids = (length(var.lambda_subnet_names) != 0) ? [aws_security_group.lambda_sg[0].id] : []
  lambda_s3_bucket          = module.download_lambda.gha_lambdas_bucket.id
  webhook_lambda_s3_key     = local.lambdas["webhook"].filename
  syncer_lambda_s3_key      = local.lambdas["runner-binaries-syncer"].filename
  runners_lambda_s3_key     = local.lambdas["runners"].filename

  tags           = var.tags
  tracing_config = var.tracing_config
  depends_on     = [module.download_lambda]
}
module "download_lambda" {
  source             = "../download-lambda"
  lambdas            = local.lambdas
  tags               = var.tags
  lambda_bucket_name = "${var.resource_name_prefix}-lambda-code-bucket"
}
