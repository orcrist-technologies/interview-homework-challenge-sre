
output "workloads" {
  description = "List of created workloads"
  value = {
    deployment = try(kubernetes_deployment.this[0].metadata[0].name, null)
    service    = try(kubernetes_service.this[0].metadata[0].name, null)
    pod        = try(kubernetes_pod.this[0].metadata[0].name, null)
    namespace  = var.namespace
  }

}

