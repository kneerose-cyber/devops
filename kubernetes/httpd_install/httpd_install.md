created namespace (better practice - assigning in a group )
labels (selector or selecting criteria) - is identification give to the pod to match desired state
 
 **MASTER NODE**
```bash
   mkdir projects
   cd projects
   mkdir httpd
```

 **Need 2 files**
 1) httpd-deployment.yaml
 2) httpd-service.yaml

**#created namesapce (better practice - assigning in a group )**
```bash
   kubectl create namespace httpd-group
   kubectl apply -f httpd-service.yaml 
   kubectl apply -f httpd-deployment.yaml

   kubectl get pods
```


**#While using type Nodeport  the port rande will be 3000-34000 range**
```bash
kubectl get service httpd-service
                   80:<3193>

curl http://<worker-external-ip>:3193
nc -vz worker-external-ip 3193

http://worker-external-ip:3193
```
**Test scenario**
 delete one pod
```bash
 kubectl delete pod <pod-name>
```
delete all pods
```bash
  kubectl delete pods --all 
```

## AUTO HEALING
After deleting the control manager get status of cluster, pods which  will spin up pods mentioned on yaml file, no interruption in the service you can keep checking the browser

## TO completely kill/shutdown httpd update 
```bash
 kubectl scale deployment httpd-deployment --replicas=0  #OR ( edit file yaml file and apply to replicas 0)
```

## check the service will be dead as well as the pods
```bash
kubectl get pods
```
