moved {
  from = aws_s3_bucket.lambda_code_bucket
  to   = module.download_lambda.aws_s3_bucket.gha_lambdas
}

moved {
  from = aws_s3_bucket_acl.lambda_code_bucket_acl
  to   = module.download_lambda.aws_s3_bucket_acl.gha_lambdas
}

moved {
  from = aws_s3_bucket_ownership_controls.lambda_code_bucket_ow
  to   = module.download_lambda.aws_s3_bucket_ownership_controls.gha_lambdas
}
