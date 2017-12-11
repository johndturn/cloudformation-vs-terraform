resource "aws_s3_bucket" "media" {
  acl    = "private"
  bucket = "${var.org_short}-media-bucket"

  tags {
    "name" = "${var.org} Media"
  }
}

resource "aws_s3_bucket_policy" "media_access" {
  bucket = "${aws_s3_bucket.media.id}"

  policy =<<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "MediaAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.media.id}/*",
      "Condition": {
        "StringLike": {
          "aws:Referer": ["https://*.${var.domain}/*", "http://localhost:3000"]
        }
      }
    }
  ]
}
POLICY
}

output "url" {
  value = "${aws_s3_bucket.media.bucket_domain_name}"
}