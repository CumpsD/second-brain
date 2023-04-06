# Create Namespace

```bash
$ kubectl get namespaces
NAME              STATUS   AGE
kube-system       Active   37m
kube-public       Active   37m
kube-node-lease   Active   37m
default           Active   37m

$ kubectl create namespace varsenare
namespace/varsenare created

$ kubectl get namespaces
NAME              STATUS   AGE
kube-system       Active   37m
kube-public       Active   37m
kube-node-lease   Active   37m
default           Active   37m
varsenare         Active   2s
```
