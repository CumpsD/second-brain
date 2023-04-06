# Traefik

## Install

```bash
$ helm repo add traefik https://traefik.github.io/charts
"traefik" has been added to your repositories

$ helm repo update
helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "traefik" chart repository
Update Complete. ⎈Happy Helming!⎈

$ helm install traefik traefik/traefik -f traefik.yaml --namespace traefik --create-namespace
NAME: traefik
LAST DEPLOYED: Thu Apr  6 22:35:22 2023
NAMESPACE: traefik
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Traefik Proxy v2.9.9 has been deployed successfully
on traefik namespace !
```

### traefik.yaml

```yaml
image:
  registry: docker.io
  repository: traefik
  tag: v2.9.10

service:
  enabled: true
  single: true
  type: LoadBalancer
  annotations:
    metallb.universe.tf/loadBalancerIPs: 10.0.50.50

ports:
  traefik:
    port: 9000
    protocol: TCP
    expose: false
    exposedPort: 9000
  web:
    port: 8000
    protocol: TCP
    expose: true
    exposedPort: 80
  websecure:
    port: 8443
    protocol: TCP
    expose: true
    exposedPort: 443
  postgres:
    port: 5432
    protocol: TCP
    expose: true
    exposedPort: 5432
  ssh:
    port: 2222
    protocol: TCP
    expose: true
    exposedPort: 22
  dns:
    port: 5353
    protocol: UDP
    expose: true
    exposedPort: 53
```

## Test

```bash
kubectl apply -n varsenare -f service-1.yaml
kubectl apply -n varsenare -f service-2.yaml
kubectl apply -n varsenare -f service-3.yaml
kubectl apply -n varsenare -f ingress.yaml

curl -H "Host: api.mysite.net" http://10.0.50.50/hello
curl -H "Host: api.myothersite.net" http://10.0.50.50/service2/hello
curl -H "Host: api.myothersite.net" http://10.0.50.50/service3/hello
```
### service-1.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: service1
spec:
  replicas: 2
  selector:
    matchLabels:
      app: service1
  template:
    metadata:
      labels:
        app: service1
    spec:
      containers:
        - name: service1
          image: mendhak/http-https-echo
          ports:
            - name: http
              containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: service1
spec:
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 8080
  selector:
    app: service1
  type: ClusterIP
```

### service-2.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: service2
spec:
  replicas: 2
  selector:
    matchLabels:
      app: service2
  template:
    metadata:
      labels:
        app: service2
    spec:
      containers:
        - name: service2
          image: mendhak/http-https-echo
          ports:
            - name: http
              containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: service2
spec:
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 8080
  selector:
    app: service2
  type: ClusterIP
```

### service-3.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: service3
spec:
  replicas: 2
  selector:
    matchLabels:
      app: service3
  template:
    metadata:
      labels:
        app: service3
    spec:
      containers:
        - name: service3
          image: mendhak/http-https-echo
          ports:
            - name: http
              containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: service3
spec:
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 8080
  selector:
    app: service3
  type: ClusterIP
```

### ingress.yaml

```yaml
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: ingress-echo
spec:
  entryPoints:
    - web

  routes:
  - match: Host(`api.mysite.net`) && PathPrefix(`/`)
    kind: Rule
    services:
    - kind: Service
      name: service1
      namespace: varsenare
      port: 80
  - match: Host(`api.myothersite.net`) && PathPrefix(`/service2`)
    kind: Rule
    services:
    - kind: Service
      name: service2
      namespace: varsenare
      port: 80
  - match: Host(`api.myothersite.net`) && PathPrefix(`/service3`)
    kind: Rule
    services:
    - kind: Service
      name: service3
      namespace: varsenare
      port: 80
```
