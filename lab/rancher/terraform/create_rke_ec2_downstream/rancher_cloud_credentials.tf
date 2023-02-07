resource "rancher2_cloud_credential" "aws" {
  name = "aws-${var.prefix}"
  amazonec2_credential_config {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }
}