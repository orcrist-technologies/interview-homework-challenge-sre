# Challenge 5: Helm Chart

## Objective

Deploy the Python HTTP server from Challenge 3 to Kubernetes using a Helm chart.

## Background

The Challenge 3 server is a Python HTTP application that:
- Listens on port **8080**
- Returns `200 OK` with `"Everything works!"` when the request includes header `Challenge: orcrist.org`
- Returns `404 Not Found` with `"Wrong header!"` otherwise

## Implementation

### Chart structure

```bash
server-chart/
├── Chart.yaml
├── values.yaml
└── templates/
    ├── _helpers.tpl
    ├── deployment.yaml
    └── service.yaml
```

## Loading the image into kind

Since the cluster runs locally via kind, the Docker image must be loaded directly onto the nodes — no registry required:

```bash
kind load docker-image challenge-3:1.0.0 --name k8s-prod-eu
```

Set `pullPolicy: IfNotPresent` in `values.yaml` so Kubernetes uses the locally loaded image instead of attempting a remote pull.

## Deployment

**Lint the chart:**

```bash
✗ helm lint ./server-chart
# ==> Linting ./server-chart

# 1 chart(s) linted, 0 chart(s) failed
```

**Render manifests:**

```bash
✗ helm template ./server-chart | grep "# Source"

# Source: server-chart/templates/service.yaml
# Source: server-chart/templates/deployment.yam
```

**Install:**

```bash
✗ helm install server ./server-chart

# NAME: server
# LAST DEPLOYED: Sun Mar 15 11:22:37 2026
# NAMESPACE: default
# STATUS: deployed
# REVISION: 1
# DESCRIPTION: Install complete
# TEST SUITE: None
# NOTES:
# 1. Get the application URL by running these commands:
#   export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=server-chart,app.kubernetes.io/instance=server" -o jsonpath="{.items[0].metadata.name}")
#   export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
#   echo "Visit http://127.0.0.1:8080 to use your application"
#   kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
```

**Verify the pod is running:**

```bash
✗ kubectl get pods
# server-server-chart-74b59f9bc6-cgfq8   1/1     Running   0   6s
```

## Validation

Port-forward to the pod and test the endpoint:

```bash

✗ export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=server-chart,app.kubernetes.io/instance=server" -o jsonpath="{.items[0].metadata.name}")
✗ export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
✗ kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
# Visit http://127.0.0.1:8080 to use your application
# Forwarding from 127.0.0.1:8080 -> 8080
# Forwarding from [::1]:8080 -> 8080

✗ curl -i -H "Challenge: orcrist.org" http://localhost:8080
# HTTP/1.0 200 OK
# Content-type: text/html
#
# Everything works!
```

## Acceptance criteria

| Criteria | Status |
|---|---|
| `helm lint` passes without errors | ✅ |
| `helm template` renders valid manifests | ✅ |
| Deployment targets container port 8080 | ✅ |
| Service correctly routes to the deployment | ✅ |
| All hardcoded values are parameterized in `values.yaml` | ✅ |

