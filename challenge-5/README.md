# Challenge 5: Helm Chart

## Objective

Create a Helm chart to deploy the Python HTTP server from Challenge 3 to Kubernetes.

## Background

The Challenge 3 server is a Python HTTP application that:
- Listens on **port 8080**
- Returns `200 OK` with "Everything works!" when the request includes header `Challenge: orcrist.org`
- Returns `404 Not Found` with "Wrong header!" otherwise

Assume the Docker image has been built from your Challenge 3 Dockerfile.

## Requirements

Complete the Helm chart in `server-chart/` with the following:

### 1. values.yaml
Define configurable values for:
- Container image (repository, tag, pull policy)
- Number of replicas
- Service configuration (type, port)
- Resource limits/requests (optional)

### 2. templates/deployment.yaml
Create a Kubernetes Deployment that:
- Deploys the container image
- Exposes container port 8080
- Uses values from values.yaml

### 3. templates/service.yaml
Create a Kubernetes Service that:
- Exposes the deployment
- Routes traffic to port 8080

### 4. (Optional) templates/_helpers.tpl
Add template helpers for consistent naming and labels.

## Deliverables

A working Helm chart that can be:
1. Validated with: `helm lint ./server-chart`
2. Rendered with: `helm template ./server-chart`
3. Installed with: `helm install server ./server-chart`

## Acceptance Criteria

- [ ] `helm lint` passes without errors
- [ ] `helm template` renders valid Kubernetes manifests
- [ ] Deployment targets container port 8080
- [ ] Service correctly routes to the deployment
- [ ] All hardcoded values are parameterized in values.yaml
