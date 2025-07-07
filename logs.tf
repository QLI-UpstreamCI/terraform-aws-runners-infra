# locals {
#   dd_log_forwarder_lambda_name = "datadog_log_forwarder"
# }

# data "aws_lambda_function" "datadog_log_forwarder" {
#   function_name = local.dd_log_forwarder_lambda_name
# }

# resource "aws_lambda_permission" "cloudwatch_lambda_permission" {
#   action        = "lambda:InvokeFunction"
#   function_name = local.dd_log_forwarder_lambda_name
#   principal     = "logs.eu-central-1.amazonaws.com"
#   source_arn    = "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/*/${var.resource_name_prefix}-*:*"
# }

# // Log subscription filter for the scale-up Lambda function
# resource "aws_cloudwatch_log_subscription_filter" "log_forwarder_scale_up" {
#   depends_on      = [aws_lambda_permission.cloudwatch_lambda_permission]
#   for_each        = module.github_runner.runners_map
#   name            = "log_forwarder_scale_up_${each.key}"
#   log_group_name  = each.value.lambda_up_log_group.name
#   filter_pattern  = ""
#   destination_arn = data.aws_lambda_function.datadog_log_forwarder.arn
# }

# // Log subscription filter for the scale-down Lambda function
# resource "aws_cloudwatch_log_subscription_filter" "log_forwarder_scale_down" {
#   depends_on      = [aws_lambda_permission.cloudwatch_lambda_permission]
#   for_each        = module.github_runner.runners_map
#   name            = "log_forwarder_scale_down_${each.key}"
#   log_group_name  = each.value.lambda_down_log_group.name
#   filter_pattern  = ""
#   destination_arn = data.aws_lambda_function.datadog_log_forwarder.arn
# }

# // Log subscription filter for the ssm-housekeeper Lambda function
# resource "aws_cloudwatch_log_subscription_filter" "log_forwarder_ssm_housekeeper" {
#   depends_on      = [aws_lambda_permission.cloudwatch_lambda_permission]
#   for_each        = module.github_runner.runners_map
#   name            = "log_forwarder_ssm_housekeeper_${each.key}"
#   log_group_name  = "/aws/lambda/${var.resource_name_prefix}-${each.key}-ssm-housekeeper"
#   filter_pattern  = ""
#   destination_arn = data.aws_lambda_function.datadog_log_forwarder.arn
# }

# // Log subscription filter for the webhook Lambda function
# resource "aws_cloudwatch_log_subscription_filter" "log_forwarder_webhook" {
#   depends_on      = [aws_lambda_permission.cloudwatch_lambda_permission]
#   name            = "log_forwarder_webhook"
#   log_group_name  = module.github_runner.webhook.lambda_log_group.name
#   filter_pattern  = ""
#   destination_arn = data.aws_lambda_function.datadog_log_forwarder.arn
# }

# // Log subscription filter for the binaries-syncer Lambda function
# resource "aws_cloudwatch_log_subscription_filter" "log_forwarder_binaries_syncer" {
#   depends_on      = [aws_lambda_permission.cloudwatch_lambda_permission]
#   for_each        = module.github_runner.binaries_syncer_map
#   name            = "log_forwarder_binaries_syncer_${each.key}"
#   log_group_name  = each.value.lambda_log_group.name
#   filter_pattern  = ""
#   destination_arn = data.aws_lambda_function.datadog_log_forwarder.arn
# }
