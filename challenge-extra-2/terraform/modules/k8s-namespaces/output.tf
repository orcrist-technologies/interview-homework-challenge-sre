output "ns" {
  description = "Map of namespace name to created namespace name"
  value       = { for k, v in kubernetes_namespace.example : k => v.metadata[0].name }
}

output "ns_list" {
  description = "List of created namespace names"
  value       = [for v in kubernetes_namespace.example : v.metadata[0].name]
}
