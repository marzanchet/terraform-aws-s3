provider "aws" {
  region = "eu-west-1"
}

module "kms_key" {
  source      = "clouddrove/kms/aws"
  version     = "0.14.0"
  name        = "kms"
  environment = "test"
  label_order = ["name", "environment"]

  enabled                 = true
  description             = "KMS key for s3"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  alias                   = "alias/s3"
  policy                  = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {
  version = "2012-10-17"
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
}


module "s3_bucket" {
  source = "./../../"

  name        = "clouddrove-encryption-bucket"
  environment = "test"
  label_order = ["name", "environment"]

  bucket_encryption_enabled = true
  acl                       = "private"
  kms_master_key_id         = module.kms_key.key_arn
}
