output "webhook_secret" {
  sensitive = true
  value     = random_id.webhook_secret.hex
}

output "webhook_endpoint" {
  value = module.github_runner.webhook.endpoint
}

output "instance_types" {
  value = {
    "small" = [
      "t3.small",
    ]
    "medium" = [
      "t3.medium",
      "t4g.medium",
    ]
    "large" = [
      "m5.large",
      "m5a.large",
      "m6i.large",
      "m6a.large",
      "m7i.large",
      "m7a.large",
      "c5.xlarge",
      "c6i.xlarge",
      "c7i.xlarge",
      "c7i-flex.xlarge",
      "r5.large",
      "r6i.large",
      "r6a.large",
      "r7i.large",
      "r7a.large",
    ]
    "xlarge" = [
      "m5.xlarge",
      "m5a.xlarge",
      "m6i.xlarge",
      "m6a.xlarge",
      "m7i.xlarge",
      "m7a.xlarge",
      "c5.2xlarge",
      "c6i.2xlarge",
      "c7i.2xlarge",
      "c7i-flex.2xlarge",
      "r5.xlarge",
      "r6i.xlarge",
      "r6a.xlarge",
      "r7i.xlarge",
      "r7a.xlarge",
    ]
    "2xlarge" = [
      "m5.2xlarge",
      "m5a.2xlarge",
      "m6i.2xlarge",
      "m6a.2xlarge",
      "m7i.2xlarge",
      "m7a.2xlarge",
      "c5.4xlarge",
      "c6i.4xlarge",
      "c7i.4xlarge",
      "c7i-flex.4xlarge",
      "r5.2xlarge",
      "r6i.2xlarge",
      "r6a.2xlarge",
      "r7i.2xlarge",
      "r7a.2xlarge",
    ]
    "4xlarge" = [
      "m5.4xlarge",
      "m7a.4xlarge",
      "m7i.4xlarge",
      "c5.9xlarge",
      "c6i.8xlarge",
      "c7i.8xlarge",
      "c7i-flex.8xlarge",
      "r5.4xlarge",
      "r6i.4xlarge",
      "r6a.4xlarge",
      "r7i.4xlarge",
      "r7a.4xlarge",
    ]
    "8xlarge" = [
      "m5.8xlarge",
      "m5a.8xlarge",
      "m7i.8xlarge",
      "m7a.8xlarge",
    ]
    "9xlarge" = [
      "c5.9xlarge",
    ]
    "4xlarge-arm" = [
      "c7g.4xlarge",
    ]
    "4xlarge-amd" = [
      "c5a.4xlarge",      
    ]
  }
}

#output "efs_id" {
#  value = aws_efs_file_system.gh-runner-efs.id
#}

#output "access_point_id" {
#  value = aws_efs_access_point.gh-runner-efs-ap.id
#}

#output "efs_dns" {
#  value = aws_efs_file_system.gh-runner-efs.dns_name
#}
