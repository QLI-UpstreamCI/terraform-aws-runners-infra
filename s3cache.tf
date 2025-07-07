resource "aws_s3_bucket" "runners-cache" {
    bucket = "${var.resource_name_prefix}-artifacts"
    tags = var.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "runners-lifecycle" {
    bucket = aws_s3_bucket.runners-cache.id

    rule {
        id = "artifacts-intelligent-transition-expiration"
        status = "Enabled"

        filter {
            prefix = ""
        }

        transition {
          days = 0 
          storage_class = "INTELLIGENT_TIERING"
        }
        
        expiration {
            days = var.s3_artifacts_expiration # Remove objects older than 45 days
        }

        abort_incomplete_multipart_upload {
          days_after_initiation = 7 # Abort incomplete uploads after 7 days
        }
    }
}