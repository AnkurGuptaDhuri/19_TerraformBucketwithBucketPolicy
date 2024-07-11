/**
 * A Terraform module that creates a tagged S3 bucket and an IAM user/key with access to the bucket
 */
variable "bucket_name" {}

/*
# we need a service account user
resource "aws_iam_user" "user" {
  name = "srv_${var.bucket_name}"
}
*/

/*
# generate keys for service account user
resource "aws_iam_access_key" "user_keys" {
  user = "${aws_iam_user.user.name}"
}
*/

# create an s3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  //force_destroy = "true"

  versioning {
    enabled = true
  }
/*
  tags {
    team          = "${var.tag_team}"
    application   = "${var.tag_application}"
    environment   = "${var.tag_environment}"
    contact-email = "${var.tag_contact-email}"
    customer      = "${var.tag_customer}"
  }

    lifecycle_rule {
      id                                     = "auto-delete-incomplete-after-x-days"
      prefix                                 = ""
      enabled                                = "${var.multipart_delete}"
      abort_incomplete_multipart_upload_days = "${var.multipart_days}"
    }
*/
}

# grant user access to the bucket
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<EOF
 {
  "Id": "Policy1720682098203",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1720682089149",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.bucket.arn}",
        "${aws_s3_bucket.bucket.arn}/*"
      ],
      "Principal": {
        "AWS": [
          "arn:aws:iam::637423425462:root"
        ]
      }
    }
  ]
 }
EOF

}