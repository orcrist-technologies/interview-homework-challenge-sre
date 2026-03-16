# Kubernetes Cluster #
resource "kind_cluster" "main" {
  name       = var.cluster["name"]
  node_image = var.cluster["node_image"]

  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true,region=eu,env=${var.env},type=workload\"\n"
      ]
      # extra_port_mappings {
      #   container_port = 80
      #   host_port      = var.host_port
      # }
    }
    node {
      role = "worker"
      kubeadm_config_patches = [
        "kind: JoinConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"region=eu,env=${var.env},type=workload\"\n"
      ]
    }
  }
}