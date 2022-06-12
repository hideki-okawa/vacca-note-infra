resource "aws_s3_bucket" "this" {
  bucket = "${local.system_name}-view"

  tags = {
    Name = "${local.system_name}-view"
  }
}

resource "aws_s3_bucket_policy" "this" {
    bucket = aws_s3_bucket.this.id
    policy = data.aws_iam_policy_document.static-www.json
}

data "aws_iam_policy_document" "static-www" {
  statement {
    sid = "Allow CloudFront"
    effect = "Allow"
    principals {
        type = "AWS"
        identifiers = [data.terraform_remote_state.routing_main.outputs.aws_cloudfront_origin_access_identity_static-www.iam_arn]
    }
    actions = [
        "s3:GetObject"
    ]

    resources = [
        "${aws_s3_bucket.this.arn}/*"
    ]
  }
}