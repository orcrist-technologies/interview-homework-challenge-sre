# Terraform Kubernetes Setup Documentation

## Overview

the Terraform config sets up a local k8s cluster using Kind, creates namespaces, and deploys sample workloads including an Nginx deployment and various pods.

## Architecture

- **Cluster**: Kind-based Kubernetes cluster with 1 control-plane and 1 worker node
- **Namespaces**: collector, integration, orcrist, monitoring, tools
- **Workloads**:
  - Nginx deployment with ClusterIP service in `orcrist` namespace
  - Sample pods in various namespaces

## Prerequisites

- Terraform >= 1.0
- Kind CLI installed
- kubectl installed
- Docker running (for Kind)

## Deployment

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Plan the deployment**:
   ```bash
   terraform plan
   ```

3. **Apply the configuration**:
   ```bash
   terraform apply
   ```

4. **Access the cluster**:
   ```bash
   kubectl cluster-info --context kind-prod-main-k8s-eu
   ```

## Modules

### k8s-kind
Creates a Kind Kubernetes cluster.

### k8s-namespaces
Creates the specified namespaces in the cluster.

### k8s-workloads
Deploys Kubernetes resources (deployments, services, pods) based on input variables.

## Variables

- `k8s_ghcr_token`: GHCR token for Kubernetes access (sensitive)

## Outputs

- `cluster_name`: Cluster name and endpoint
- `namespaces`: List of created namespaces
- `nginx-svc`: Nginx service details

## Maintenance

- Update variables in `terraform.tfvars`
- Modify workloads in `main.tf`
- Run `terraform fmt` to format code
- Use `terraform validate` to check syntax
