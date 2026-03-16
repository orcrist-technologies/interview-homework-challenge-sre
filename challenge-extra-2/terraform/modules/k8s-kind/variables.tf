variable "cluster" {
  description = "cluster config"
  type        = map(string)
  default = {
    name       = "dev-k8s-eu"
    node_image = "kindest/node:v1.27.3"

  }
}
# variable "host_port" {
#   description = "Host port for port mapping (for ingress/ArgoCD)"
#   type        = number
#   default     = 8080
# }

variable "env" {
  description = "environment name (dev, stage, prod)"
  type        = string
  default     = "dev"
}