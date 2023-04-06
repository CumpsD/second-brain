# MicroK8s

## Install

```bash
$ snap info microk8s
$ sudo snap install microk8s --classic --channel=1.26/stable
microk8s (1.26/stable) v1.26.3 from Canonical✓ installed
$ sudo iptables -P FORWARD ACCEPT
$ sudo apt-get install iptables-persistent
```

## Upgrade

**IMPORTANT NOTE**: Add-ons, unless specified otherwise in the documentation, will **NOT** be upgraded as part of a MicroK8s upgrade. Currently, the most effective way to upgrade these add-ons is to use `microk8s disable <add-on>` and then re-enable them. Please make sure to read the [release notes](https://microk8s.io/docs/release-notes) for specific details referring to add-ons before upgrading.

```bash
$ sudo snap refresh microk8s --channel=1.27/stable
```

## Configure Firewall

```bash
$ sudo ufw allow 16443/tcp
```

## Configure User

```bash
$ sudo usermod -a -G microk8s $USER
$ sudo chown -f -R $USER ~/.kube
$ su - $USER
```

## Check Kubernetes

```bash
$ microk8s status --wait-ready
microk8s is running
high-availability: no
  datastore master nodes: 127.0.0.1:19001
  datastore standby nodes: none
addons:
  enabled:
    ha-cluster           # (core) Configure high availability on the current node
    helm                 # (core) Helm - the package manager for Kubernetes
    helm3                # (core) Helm 3 - the package manager for Kubernetes
  disabled:
    cert-manager         # (core) Cloud native certificate management
    community            # (core) The community addons repository
    dashboard            # (core) The Kubernetes dashboard
    dns                  # (core) CoreDNS
    gpu                  # (core) Automatic enablement of Nvidia CUDA
    host-access          # (core) Allow Pods connecting to Host services smoothly
    hostpath-storage     # (core) Storage class; allocates storage from host directory
    ingress              # (core) Ingress controller for external access
    kube-ovn             # (core) An advanced network fabric for Kubernetes
    mayastor             # (core) OpenEBS MayaStor
    metallb              # (core) Loadbalancer for your Kubernetes cluster
    metrics-server       # (core) K8s Metrics Server for API access to service metrics
    minio                # (core) MinIO object storage
    observability        # (core) A lightweight observability stack for logs, traces and metrics
    prometheus           # (core) Prometheus operator for monitoring and logging
    rbac                 # (core) Role-Based Access Control for authorisation
    registry             # (core) Private image registry exposed on localhost:32000
    storage              # (core) Alias to hostpath-storage add-on, deprecated

$ microk8s kubectl get nodes
NAME    STATUS   ROLES    AGE   VERSION
docky   Ready    <none>   93s   v1.26.3

$ microk8s kubectl get services
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.152.183.1   <none>        443/TCP   108s

$ microk8s kubectl get pods
No resources found in default namespace.

$ alias kubectl='microk8s kubectl'
$ kubectl version --short
Client Version: v1.26.3
Kustomize Version: v4.5.7
Server Version: v1.26.3

$ kubectl get all --all-namespaces
NAMESPACE     NAME                                           READY   STATUS    RESTARTS   AGE
kube-system   pod/calico-node-k5qgt                          1/1     Running   0          6m31s
kube-system   pod/calico-kube-controllers-79568db7f8-bnzg7   1/1     Running   0          6m31s
kube-system   pod/coredns-6f5f9b5d74-b9dmf                   1/1     Running   0          4m33s
kube-system   pod/hostpath-provisioner-69cd9ff5b8-vq85x      1/1     Running   0          3m14s

NAMESPACE     NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes   ClusterIP   10.152.183.1    <none>        443/TCP                  6m39s
kube-system   service/kube-dns     ClusterIP   10.152.183.10   <none>        53/UDP,53/TCP,9153/TCP   4m33s

NAMESPACE     NAME                         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   daemonset.apps/calico-node   1         1         1       1            1           kubernetes.io/os=linux   6m37s

NAMESPACE     NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/calico-kube-controllers   1/1     1            1           6m37s
kube-system   deployment.apps/coredns                   1/1     1            1           4m33s
kube-system   deployment.apps/hostpath-provisioner      1/1     1            1           4m5s

NAMESPACE     NAME                                                 DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/calico-kube-controllers-79568db7f8   1         1         1       6m31s
kube-system   replicaset.apps/coredns-6f5f9b5d74                   1         1         1       4m33s
kube-system   replicaset.apps/hostpath-provisioner-69cd9ff5b8      1         1         1       3m14s
```

## Add Add-ons

```bash
$ microk8s enable community
Infer repository core for addon community
Cloning into '/var/snap/microk8s/common/addons/community'...
done.
Community repository is now enabled

$ microk8s enable dns
Infer repository core for addon dns
Enabling DNS
Using host configuration from /run/systemd/resolve/resolv.conf
Applying manifest
serviceaccount/coredns created
configmap/coredns created
deployment.apps/coredns created
service/kube-dns created
clusterrole.rbac.authorization.k8s.io/coredns created
clusterrolebinding.rbac.authorization.k8s.io/coredns created
Restarting kubelet
DNS is enabled

$ microk8s enable hostpath-storage
Infer repository core for addon hostpath-storage
Enabling default storage class.
WARNING: Hostpath storage is not suitable for production environments.
deployment.apps/hostpath-provisioner created
storageclass.storage.k8s.io/microk8s-hostpath created
serviceaccount/microk8s-hostpath created
clusterrole.rbac.authorization.k8s.io/microk8s-hostpath created
clusterrolebinding.rbac.authorization.k8s.io/microk8s-hostpath created
Storage will be available soon.
```

## Start/Stop

```bash
$ microk8s start
$ microk8s stop
```

## Get Kubectl Config

```bash
$ microk8s config
```
