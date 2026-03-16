
terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.10.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }
}


provider "kind" {}


provider "kubernetes" {
  host = module.k8s_eu.k8s_cluster_details.endpoint

  client_certificate     = module.k8s_eu.k8s_cluster_details.client_certificate
  client_key             = module.k8s_eu.k8s_cluster_details.client_key
  cluster_ca_certificate = module.k8s_eu.k8s_cluster_details.cluster_ca_certificate
}

# provider "kubectl" {
#   load_config_file       = "false"
#   host                   = module.k8s_eu.k8s_cluster_details.endpoint
#   client_certificate     = module.k8s_eu.k8s_cluster_details.client_certificate
#   client_key             = module.k8s_eu.k8s_cluster_details.client_key
#   cluster_ca_certificate = module.k8s_eu.k8s_cluster_details.cluster_ca_certificate
# }

