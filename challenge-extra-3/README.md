# Challenge Extra 3: Helm Chart Testing with chart-testing

## Objective

i'm using`chart-testing` (`ct`), verifying the Deployment and Service are rendered and reachable correctly.

## Setup

### Directory structure

```bash
challenge-extra-3/
├── ct.yaml
└── server-chart/
    ├── Chart.yaml
    ├── values.yaml
    └── templates/
        └── tests/
            └── test-deployment.yaml
            └── test-service.yaml
```

### ct.yaml

```yaml
chart-dirs:
  - .
charts:
  - server-chart
helm-extra-args: --timeout 60s
```

### templates/tests/test-deployment.yaml
> Verifies the app responds with the correct header

### templates/tests/test-service.yaml
 > Verifies the service resolves and routes traffic to the pod

## Running the tests

`ct` creates an isolated namespace, installs the chart, runs the test hook, then cleans up.

```bash
✗ ct install

Creating namespace "server-chart-c841c2xj9v"...              # Chart installed into ephemeral namespace:**
NAME: server-chart-c841c2xj9v
STATUS: deployed
REVISION: 1

deployment "server-chart-c841c2xj9v" successfully rolled out #  Deployment rolled out

Container image `challenge-3:1.0.0` was already present on the node (loaded via `kind load`), so no pull was needed.



TEST SUITE:     server-chart-c841c2xj9v-test                # Test pod ran and succeeded
Phase:          Succeeded

INFO:root:Listening on 8080...                              # App logs confirm the server received the request:

10.244.1.26 - - [15/Mar/2026 14:28:01] "GET / HTTP/1.1" 404 -

HTTP/1.0 404 Not Found                                      # Test pod logs confirm the service responded:
Wrong header!

Deleting release "server-chart-c841c2xj9v"...               # cleanup
Deleting namespace "server-chart-c841c2xj9v"...             # cleanup

✔︎ server-chart => (version: "0.1.0", path: "./server-chart") # test result
All charts installed successfully
```
