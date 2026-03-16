## Production Cluster ##

module "k8s_eu" {
  source = "../../../modules/k8s-kind"
  env    = "prod"
  cluster = {
    name       = "prod-main-k8s-eu"
    node_image = "kindest/node:v1.27.3"
  }
}

# k8s namespaces
module "namespaces" {
  source     = "../../../modules/k8s-namespaces"
  namespaces = ["collector", "integration", "orcrist", "monitoring", "tools"]
}

# nginx service with deployment and service
module "nginx" {

  source    = "../../../modules/k8s-workloads"
  namespace = "orcrist"
  name      = "nginx"
  deployment = {
    replicas = 3
    image    = "nginx:latest"
  }

  service = {
    type        = "ClusterIP"
    port        = 80
    target_port = 80
    protocol    = "TCP"
  }
  depends_on = [module.namespaces]
}


### pod only (no deployment, no service) ###
module "pod_example_orcrist" {
  source    = "../../../modules/k8s-workloads"
  name      = "pod-example-orcrist"
  namespace = module.namespaces.ns["orcrist"]

  pod = {
    image = "alpine"
    name  = "pod"
    args  = ["cat"]
    tty   = true
    stdin = true
  }

  depends_on = [module.namespaces]
}

module "pod_nginx_tools" {
  source    = "../../../modules/k8s-workloads"
  name      = "pod-nginx-tools"
  namespace = module.namespaces.ns["tools"]

  pod = {
    image = "nginx"
    name  = "pod"
    ports = [{
      name           = "web"
      container_port = 80
      protocol       = "TCP"
    }]
  }

  depends_on = [module.namespaces]
}

module "pod_example_integration" {
  source    = "../../../modules/k8s-workloads"
  name      = "pod-example-integration"
  namespace = module.namespaces.ns["integration"]

  pod = {
    image = "alpine"
    name  = "pod"
    args  = ["cat"]
    tty   = true
    stdin = true
  }

  depends_on = [module.namespaces]
}

module "pod_example_monitoring" {
  source    = "../../../modules/k8s-workloads"
  name      = "pod-example-monitoring"
  namespace = module.namespaces.ns["monitoring"]

  pod = {
    image = "alpine"
    name  = "pod"
    args  = ["cat"]
    tty   = true
    stdin = true
  }

  depends_on = [module.namespaces]
}
