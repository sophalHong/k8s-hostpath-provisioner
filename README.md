# k8s-hostpath-provisioner
A dynamic provisioning of Kubernetes Hostpath volumes.  
This project is created based on an example from [kubernetes-sigs/sig-storage-lib-external-provisioner](https://github.com/kubernetes-sigs/sig-storage-lib-external-provisioner).

## Build
```shell
make
```

## Deploy
```shell
kubectl apply -f ./deploy/operator.yaml
kubectl apply -f ./deploy/test.yaml
timeout 30 bash -c "until kubectl get pod test-pod -o=jsonpath='{.status.phase}' | grep -E 'Succeeded|Failed'; do sleep 1; done"
```
