output "cluster_name" {
  description = "Name of the created cluster"
  value = {
    name     = module.k8s_eu.k8s_cluster_details.name
    endpoint = module.k8s_eu.k8s_cluster_details.endpoint
  }
}

output "namespaces" {
  description = "List of created namespaces"
  value       = module.namespaces.ns_list

}

output "nginx-svc" {
  description = "Details of the nginx service"
  value = {
    namespace  = module.nginx.workloads["namespace"]
    deployment = module.nginx.workloads["deployment"]
    service    = module.nginx.workloads["service"]

  }
}

output "pod_example_orcrist" {

  description = "Details of the nginx service"
  value = {
    namespace  = module.pod_example_orcrist.workloads["namespace"]
    deployment = module.pod_example_orcrist.workloads["deployment"]
    service    = module.pod_example_orcrist.workloads["service"]

  }
}

output "pod_nginx_tools" {

  description = "Details of the nginx service"
  value = {
    namespace  = module.pod_nginx_tools.workloads["namespace"]
    deployment = module.pod_nginx_tools.workloads["deployment"]
    service    = module.pod_nginx_tools.workloads["service"]
    pod        = module.pod_nginx_tools.workloads["pod"]
  }
}

output "pod_example_integration" {

  description = "Details of the nginx service"
  value = {
    namespace  = module.pod_example_integration.workloads["namespace"]
    deployment = module.pod_example_integration.workloads["deployment"]
    service    = module.pod_example_integration.workloads["service"]
    pod        = module.pod_example_monitoring.workloads["pod"]
  }
}

output "pod_example_monitoring" {

  description = "Details of the nginx service"
  value = {
    namespace  = module.pod_example_monitoring.workloads["namespace"]
    deployment = module.pod_example_monitoring.workloads["deployment"]
    service    = module.pod_example_monitoring.workloads["service"]
    pod        = module.pod_example_monitoring.workloads["pod"]

  }
}

