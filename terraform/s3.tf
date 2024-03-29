# s3.tf

resource "aws_s3_bucket" "workspace" {
  bucket = "${var.campaign_prefix}-${var.campaign_name}-workspace"
  acl    = "private"

  tags = {
    Name        = "${var.campaign_prefix}-${var.campaign_name}-workspace"
  }
}