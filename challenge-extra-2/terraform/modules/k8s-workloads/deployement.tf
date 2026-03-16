resource "kubernetes_deployment" "this" {
  count = var.deployment != null ? 1 : 0

  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = local.labels
  }

  spec {
    replicas = var.deployment.replicas

    selector {
      match_labels = local.labels
    }

    template {
      metadata {
        labels = local.labels
      }

      spec {
        container {
          name  = var.name
          image = var.deployment.image

          resources {
            limits = {
              cpu    = var.deployment.resources.limits.cpu
              memory = var.deployment.resources.limits.memory
            }
            requests = {
              cpu    = var.deployment.resources.requests.cpu
              memory = var.deployment.resources.requests.memory
            }
          }
        }
      }
    }
  }
}