resource "kubernetes_namespace" "example" {
  for_each = toset(var.namespaces)
  metadata {
    name = each.value
  }
}
