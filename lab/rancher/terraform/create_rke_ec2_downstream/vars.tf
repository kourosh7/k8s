variable rancher2_token_key {}
variable aws_access_key {}
variable aws_secret_key {}
variable rancher_url {}

variable aws_region {
    default = "us-east-1"
}
variable aws_zone {
    default = "a"
}
variable rke_node_template_name{
    default = "rke-ec2-template"
}
variable rke_cluster_name {
    default = "rke-ec2-downstream"
}

variable cp_count {
    default = "1"
}

variable wk_count {
    default = "1"
}

variable aws_subnet {
    default = "subnet-ab21ac85"
}
variable aws_vpc {
    default = "vpc-e23ae898"
}
variable aws_nsg {
    default = "all-open"
}
variable aws_ami {
    default = "ami-04505e74c0741db8d"
}
variable aws_instance_type {
    default = "t3a.large"
}

variable prefix {
    default = "lprates"
}

variable iam_profile {
    default = "rk-all-role"
}

variable kubernetes_version {
    default = "v1.23.15-rancher1-1"
}
