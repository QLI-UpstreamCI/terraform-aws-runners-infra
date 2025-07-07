data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "runners_policies" {
  for_each = var.policies_per_runner
  name     = "${var.resource_name_prefix}-${each.key}"
  policy   = each.value.policy
}

resource "aws_iam_policy_attachment" "runners_policies_attachment" {
  for_each   = var.policies_per_runner
  name       = "${each.key}-attachment"
  roles      = [module.github_runner.runners_map[each.value.runner_key].role_runner.name]
  policy_arn = aws_iam_policy.runners_policies[each.key].arn
}

output "runners_map_contents" {
  value = module.github_runner.runners_map
}
