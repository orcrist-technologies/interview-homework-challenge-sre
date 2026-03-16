resource "kubernetes_service" "this" {
  count = var.service != null ? 1 : 0

  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = local.labels
  }

  spec {
    selector         = local.labels
    type             = var.service.type
    session_affinity = var.service.session_affinity

    port {
      port        = var.service.port
      target_port = var.service.target_port
    }
  }
}
