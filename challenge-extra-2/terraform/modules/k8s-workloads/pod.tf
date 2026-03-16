
resource "kubernetes_pod" "this" {
  count = var.pod != null ? 1 : 0

  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = local.labels
  }

  spec {
    dynamic "affinity" {
      for_each = var.pod.affinity != null ? [var.pod.affinity] : []
      content {
        dynamic "pod_affinity" {
          for_each = affinity.value.pod_affinity != null ? [affinity.value.pod_affinity] : []
          content {
            dynamic "required_during_scheduling_ignored_during_execution" {
              for_each = pod_affinity.value.required
              content {
                topology_key = required_during_scheduling_ignored_during_execution.value.topology_key
                label_selector {
                  dynamic "match_expressions" {
                    for_each = required_during_scheduling_ignored_during_execution.value.match_expressions
                    content {
                      key      = match_expressions.value.key
                      operator = match_expressions.value.operator
                      values   = match_expressions.value.values
                    }
                  }
                }
              }
            }
          }
        }

        dynamic "pod_anti_affinity" {
          for_each = affinity.value.pod_anti_affinity != null ? [affinity.value.pod_anti_affinity] : []
          content {
            dynamic "preferred_during_scheduling_ignored_during_execution" {
              for_each = pod_anti_affinity.value.preferred
              content {
                weight = preferred_during_scheduling_ignored_during_execution.value.weight
                pod_affinity_term {
                  topology_key = preferred_during_scheduling_ignored_during_execution.value.topology_key
                  label_selector {
                    dynamic "match_expressions" {
                      for_each = preferred_during_scheduling_ignored_during_execution.value.match_expressions
                      content {
                        key      = match_expressions.value.key
                        operator = match_expressions.value.operator
                        values   = match_expressions.value.values
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    container {
      name  = var.name
      image = var.pod.image
    }
  }
}
