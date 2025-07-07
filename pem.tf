data "aws_secretsmanager_secret" "ghapp_pem_id" {
  provider = aws.secrets_manager_provider
  name     = var.gh_app_pem_secret_name
}

data "aws_secretsmanager_secret_version" "github_app_pem" {
  provider  = aws.secrets_manager_provider
  secret_id = data.aws_secretsmanager_secret.ghapp_pem_id.id
}