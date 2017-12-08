provider "aws" {
  region = "${var.region}"
}

///////////////////////////////////////////////////
////////////////// MODULES
module "buckets" {
  source = "./buckets"

  org       = "${var.org}"
  org_short = "${var.org_short}"
  domain    = "${var.domain}"
}

///////////////////////////////////////////////////
////////////////// OUTPUTS
output "bucket-url" {
  value = "${module.buckets.url}"
}