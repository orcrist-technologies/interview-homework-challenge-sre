
output "k8s_cluster_details" {
  value = {
    name                   = kind_cluster.main.name
    endpoint               = kind_cluster.main.endpoint
    kubeconfig             = kind_cluster.main.kubeconfig
    client_certificate     = kind_cluster.main.client_certificate
    client_key             = kind_cluster.main.client_key
    cluster_ca_certificate = kind_cluster.main.cluster_ca_certificate
  }
  description = "Kind cluster details"
}