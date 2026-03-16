
# Extra Challenge 1: Kubernetes

## apply resources

```bash
✗ kubectl apply -f challenge-extra-1/manifests/

# namespace/collector created
# namespace/integration created
# namespace/orcrist created
# namespace/monitoring created
# namespace/tools created
# deployment.apps/nginx-deployment created
# service/nginx-service created
# pod/pod-example-orcrist created
# pod/pod-nginx-tools created
# pod/pod-example-integration created
# pod/pod-example-monitoring created
```

## Get all namespaces

```bash
 ✗ kubectl get ns

# NAME                 STATUS   AGE
# collector            Active   68s
# default              Active   26d
# integration          Active   68s
# kube-node-lease      Active   26d
# kube-public          Active   26d
# kube-system          Active   26d
# local-path-storage   Active   26d
# monitoring           Active   68s
# orcrist              Active   68s
# tools                Active   68s
```

## Get all pods from all namespaces

```bash
 ✗ kubectl get pods -A

# NAMESPACE            NAME                                                READY   STATUS    RESTARTS       AGE
# integration          pod-example-integration                             1/1     Running   0              99s
# kube-system          coredns-76f75df574-bdvnj                            1/1     Running   1 (10h ago)    26d
# kube-system          coredns-76f75df574-fdb6q                            1/1     Running   1 (10h ago)    26d
# kube-system          etcd-k8s-prod-eu-control-plane                      1/1     Running   0              10h
# kube-system          kindnet-24hvw                                       1/1     Running   2 (10h ago)    26d
# kube-system          kindnet-67pwd                                       1/1     Running   2 (10h ago)    26d
# kube-system          kube-apiserver-k8s-prod-eu-control-plane            1/1     Running   0              10h
# kube-system          kube-controller-manager-k8s-prod-eu-control-plane   1/1     Running   10 (10h ago)   26d
# kube-system          kube-proxy-576hd                                    1/1     Running   1 (10h ago)    26d
# kube-system          kube-proxy-6jnhm                                    1/1     Running   1 (10h ago)    26d
# kube-system          kube-scheduler-k8s-prod-eu-control-plane            1/1     Running   10 (10h ago)   26d
# local-path-storage   local-path-provisioner-6f8956fb48-rp9l6             1/1     Running   2 (10h ago)    26d
# monitoring           pod-example-monitoring                              1/1     Running   0              99s
# orcrist              nginx-deployment-7c79c4bf97-gqwll                   1/1     Running   0              99s
# orcrist              nginx-deployment-7c79c4bf97-jqm7z                   1/1     Running   0              99s
# orcrist              nginx-deployment-7c79c4bf97-jw4d2                   1/1     Running   0              99s
# orcrist              pod-example-orcrist                                 1/1     Running   0              99s
# tools                pod-nginx-tools                                     1/1     Running   0              99s
```

## Get all resources from all namespaces

```bash
 ✗ kubectl get all -A

# NAMESPACE     NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE
# default       service/kubernetes      ClusterIP   10.96.0.1       <none>        443/TCP                  8m3s
# kube-system   service/kube-dns        ClusterIP   10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP   26d
# orcrist       service/nginx-service   ClusterIP   10.96.161.242   <none>        80/TCP                   2m21s

# NAMESPACE            NAME                                     READY   UP-TO-DATE   AVAILABLE   AGE
# kube-system          deployment.apps/coredns                  2/2     2            2           26d
# local-path-storage   deployment.apps/local-path-provisioner   1/1     1            1           26d
# orcrist              deployment.apps/nginx-deployment         3/3     3            3           2m21s
```

## Get all services from namespace orcrist

```bash
 ✗ kubectl get svc -n orcrist

# NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
# nginx-service   ClusterIP   10.96.161.242   <none>        80/TCP    3m18s
```

## Get all deployments from tools.

```bash
 ✗ kubectl get deploy -n tools

# No resources found in tools namespace.
```

## Get image from nginx deployment on orcrist namespace

```bash
 ✗ kubectl get deployment nginx-deployment -n orcrist -o json | jq '.spec.template.spec.containers[].image'

# "nginx:latest"
```

## Create a port-forward to access nginx pod on orcrist namespace

```bash
 ✗ export POD_NAME=$(kubectl get pods -n orcrist -l app=nginx -o jsonpath="{.items[0].metadata.name}")
export CONTAINER_PORT=$(kubectl get pod -n orcrist $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
kubectl port-forward -n orcrist $POD_NAME 8080:$CONTAINER_PORT

# Forwarding from 127.0.0.1:8080 -> 80
# Forwarding from [::1]:8080 -> 80
```
