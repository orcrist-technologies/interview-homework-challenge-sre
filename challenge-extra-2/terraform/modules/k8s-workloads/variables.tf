variable "name" {
  description = "Name used for all resources"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "default"
}

variable "labels" {
  description = "Labels applied to all resources"
  type        = map(string)
  default     = {}
}

# ─── Deployment ───────────────────────────────────────────────────────────────

variable "deployment" {
  description = "Deployment config. Set to null to skip."
  type = object({
    replicas = optional(number, 1)
    image    = string
    resources = optional(object({
      limits = optional(object({
        cpu    = optional(string, "0.5")
        memory = optional(string, "512Mi")
      }), {})
      requests = optional(object({
        cpu    = optional(string, "250m")
        memory = optional(string, "50Mi")
      }), {})
    }), {})
    liveness_probe = optional(object({
      path                  = optional(string, "/")
      port                  = optional(number, 80)
      initial_delay_seconds = optional(number, 3)
      period_seconds        = optional(number, 3)
    }), null)
  })
  default = null
}

# ─── Pod ──────────────────────────────────────────────────────────────────────

variable "pod" {
  description = "Standalone pod config. Set to null to skip."
  type = object({
    image = string
    affinity = optional(object({
      pod_affinity = optional(object({
        required = optional(list(object({
          topology_key = string
          match_expressions = list(object({
            key      = string
            operator = string
            values   = list(string)
          }))
        })), [])
      }), null)
      pod_anti_affinity = optional(object({
        preferred = optional(list(object({
          weight       = number
          topology_key = string
          match_expressions = list(object({
            key      = string
            operator = string
            values   = list(string)
          }))
        })), [])
      }), null)
    }), null)
  })
  default = null
}

# ─── Service ──────────────────────────────────────────────────────────────────

variable "service" {
  description = "Service config. Set to null to skip."
  type = object({
    type             = optional(string, "ClusterIP")
    port             = optional(number, 80)
    target_port      = optional(number, 80)
    session_affinity = optional(string, "None")
  })
  default = null
}
