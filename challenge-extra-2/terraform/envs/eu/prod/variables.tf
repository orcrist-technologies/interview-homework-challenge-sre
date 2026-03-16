
variable "git_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}
variable "k8s_ghcr_token" {
  description = "ghcr classic token for k8s access"
  type        = string
  sensitive   = true
}