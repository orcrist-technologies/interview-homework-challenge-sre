locals {
  labels = merge({ app = var.name }, var.labels)
}