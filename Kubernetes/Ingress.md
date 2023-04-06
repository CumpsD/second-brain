# Ingress

## Enable MetalLB

```bash
$ microk8s enable metallb:10.0.50.1-10.0.50.255
Infer repository core for addon metallb
Enabling MetalLB
Applying Metallb manifest
customresourcedefinition.apiextensions.k8s.io/addresspools.metallb.io created
customresourcedefinition.apiextensions.k8s.io/bfdprofiles.metallb.io created
customresourcedefinition.apiextensions.k8s.io/bgpadvertisements.metallb.io created
customresourcedefinition.apiextensions.k8s.io/bgppeers.metallb.io created
customresourcedefinition.apiextensions.k8s.io/communities.metallb.io created
customresourcedefinition.apiextensions.k8s.io/ipaddresspools.metallb.io created
customresourcedefinition.apiextensions.k8s.io/l2advertisements.metallb.io created
namespace/metallb-system created
serviceaccount/controller created
serviceaccount/speaker created
clusterrole.rbac.authorization.k8s.io/metallb-system:controller created
clusterrole.rbac.authorization.k8s.io/metallb-system:speaker created
role.rbac.authorization.k8s.io/controller created
role.rbac.authorization.k8s.io/pod-lister created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:controller created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:speaker created
rolebinding.rbac.authorization.k8s.io/controller created
secret/webhook-server-cert created
service/webhook-service created
rolebinding.rbac.authorization.k8s.io/pod-lister created
daemonset.apps/speaker created
deployment.apps/controller created
validatingwebhookconfiguration.admissionregistration.k8s.io/validating-webhook-configuration created
Waiting for Metallb controller to be ready.
deployment.apps/controller condition met
ipaddresspool.metallb.io/default-addresspool created
l2advertisement.metallb.io/default-advertise-all-pools created
MetalLB is enabled
```

## Enable Ingress

```bash
$ microk8s enable ingress
Infer repository core for addon ingress
Enabling Ingress
ingressclass.networking.k8s.io/public created
ingressclass.networking.k8s.io/nginx created
namespace/ingress created
serviceaccount/nginx-ingress-microk8s-serviceaccount created
clusterrole.rbac.authorization.k8s.io/nginx-ingress-microk8s-clusterrole created
role.rbac.authorization.k8s.io/nginx-ingress-microk8s-role created
clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
rolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
configmap/nginx-load-balancer-microk8s-conf created
configmap/nginx-ingress-tcp-microk8s-conf created
configmap/nginx-ingress-udp-microk8s-conf created
daemonset.apps/nginx-ingress-microk8s-controller created
Ingress is enabled
```

## Testing

```bash
kubectl apply -n varsenare -f service-1.yaml
kubectl apply -n varsenare -f service-2.yaml
kubectl apply -n varsenare -f service-3.yaml
kubectl apply -n varsenare -f ingress.yaml
kubectl apply -n ingress -f lb.yaml

curl -H "Host: api.mysite.net" http://10.0.50.250/hello
curl -H "Host: api.myothersite.net" http://10.0.50.250/service2/hello
curl -H "Host: api.myothersite.net" http://10.0.50.250/service3/hello
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
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-echo
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
    nginx.ingress.kubernetes.io/use-forwarded-headers: "true"
spec:
  rules:
  - host: "api.mysite.net"
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: service1
            port:
              number: 80
  - host: "api.myothersite.net"
    http:
      paths:
      - pathType: Prefix
        path: "/service2/(.*)"
        backend:
          service:
            name: service2
            port:
              number: 80
      - pathType: Prefix
        path: "/service3/(.*)"
        backend:
          service:
            name: service3
            port:
              number: 80
```

### lb.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: lb-echo
  namespace: ingress
  annotations:
    metallb.universe.tf/loadBalancerIPs: 10.0.50.250
spec:
  type: LoadBalancer
  selector:
    name: nginx-ingress-microk8s
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 80
    - name: https
      protocol: TCP
      port: 443
      targetPort: 443
```
