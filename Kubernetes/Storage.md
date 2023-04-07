# Storage

## Inspect

```bash
kubectl get storageclass
kubectl get pod,pvc --all-namespaces
kubectl describe pv --all-namespaces
```

## Fixed Mounts

### Setup StorageClass

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: manual
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: Immediate
```

```bash
$ kubectl apply -f manual-sc.yaml
storageclass.storage.k8s.io/manual created

$ kubectl patch storageclass manual -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
storageclass.storage.k8s.io/manual patched

$ kubectl get storageclass manual
NAME               PROVISIONER                    RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
manual (default)   kubernetes.io/no-provisioner   Delete          Immediate           false                  31s
```

### Usage

> Once bound, PersistentVolumeClaim binds are exclusive, regardless of how they were bound. **A PVC to PV binding is a one-to-one mapping.**

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes: [ReadWriteOnce]
  hostPath:
    path: "/data/task"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  storageClassName: manual
  volumeName: task-pv-volume
  accessModes: [ReadWriteOnce]
  resources: { requests: { storage: 1Gi } }
---
apiVersion: v1
kind: Pod
metadata:
  name: task-pv-pod
spec:
  volumes:
    - name: pvc
      persistentVolumeClaim:
        claimName: task-pv-claim
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
      volumeMounts:
        - name: pvc
          mountPath: /usr/share/nginx/html
```

```bash
$ kubectl apply -f pv-test.yaml
persistentvolume/task-pv-volume created
persistentvolumeclaim/task-pv-claim created
pod/task-pv-pod created

$ kubectl describe pv
Name:            task-pv-volume
Labels:          type=local
Annotations:     pv.kubernetes.io/bound-by-controller: yes
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    manual
Status:          Bound
Claim:           default/task-pv-claim
Reclaim Policy:  Retain
Access Modes:    RWO
VolumeMode:      Filesystem
Capacity:        10Gi
Node Affinity:   <none>
Message:
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /data/task
    HostPathType:
Events:            <none>
```

## Dynamic Mounts (hostpath-storage)

### Setup StorageClass

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: raid0-hostpath
provisioner: microk8s.io/hostpath
reclaimPolicy: Delete
parameters:
  pvDir: /data/k8s
volumeBindingMode: WaitForFirstConsumer
```

```bash
$ kubectl apply -f raid0-hostpath-sc.yaml
storageclass.storage.k8s.io/raid0-hostpath created

$ kubectl patch storageclass microk8s-hostpath -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
storageclass.storage.k8s.io/microk8s-hostpath patched

$ kubectl get storageclass raid0-hostpath
NAME             PROVISIONER            RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
raid0-hostpath   microk8s.io/hostpath   Delete          WaitForFirstConsumer   false                  49s
```

### Usage

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc-raid0
spec:
  storageClassName: raid0-hostpath
  accessModes: [ReadWriteOnce]
  resources: { requests: { storage: 1Gi } }
---
apiVersion: v1
kind: Pod
metadata:
  name: test-nginx-raid0
spec:
  volumes:
    - name: pvc
      persistentVolumeClaim:
        claimName: test-pvc-raid0
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
      volumeMounts:
        - name: pvc
          mountPath: /usr/share/nginx/html
```

```bash
$ kubectl apply -f raid0-test.yaml
persistentvolumeclaim/test-pvc-raid0 created
pod/test-nginx-raid0 created

$ kubectl describe pv
Name:              pvc-0607539e-f6e3-4b6d-8a49-89f021515410
Labels:            <none>
Annotations:       hostPathProvisionerIdentity: docky
                   pv.kubernetes.io/provisioned-by: microk8s.io/hostpath
Finalizers:        [kubernetes.io/pv-protection]
StorageClass:      raid0-hostpath
Status:            Bound
Claim:             default/test-pvc-raid0
Reclaim Policy:    Delete
Access Modes:      RWO
VolumeMode:        Filesystem
Capacity:          1Gi
Node Affinity:
  Required Terms:
    Term 0:        kubernetes.io/hostname in [docky]
Message:
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /data/k8s/default-test-pvc-raid0-pvc-0607539e-f6e3-4b6d-8a49-89f021515410
    HostPathType:  DirectoryOrCreate
Events:            <none>
```
