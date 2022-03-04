resource "rancher2_cluster" "eks_create_01" {
  name = "createeks01"
  description = "lprates lab environment"
  eks_config_v2 {
    cloud_credential_id = rancher2_cloud_credential.aws.id
    name = var.aws_eks_name
    region = var.aws_region
    imported = false
    public_access = true
    kubernetes_version = "1.21"
    # kms_key = var.aws_kms_key
    # secrets_encryption = true
    node_groups {
      name = "ng01"
    }
  }
}