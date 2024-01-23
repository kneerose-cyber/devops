
* monolith -  whole application running on one server, application deployed as a single unit, tightly coupled, if the host goes down all application is down or even break-fix/upgrade it might take the whole application down until it's clustered env.

* micro services -  small independent services communicate with each other using APIs and are loosely coupled, for example, facebook Messenger and feed might be running on different servers so only 1 service will be impacted(meaning feed down) instead of the whole application going down.

* pods vs container -  pods is the smallest unit in Kubernetes and can host multiple containers in a pod but it is recommended to do 1 pod = 1 container.  The container is an isolated and executable software package like Nginx, httpd, etc. Pods are useful for scenarios where containers need to share resources, such as network or storage, and are deployed and scaled together.

* config - to run container (yaml file) manifest (desired state), nginx container, etc, ENV variable, it will create pod on the worker node

* labels (selector or selecting criteria) - is identification given to the pod to match the desired state

* selectors are criteria where you're matching.
* service
    node font, cluster IP, and load balancer 

* auto healing - try to delete pod and app won't stop within a second scheduler gets informed, schedule sends request to create a new pod,  


* Pods without a Higher-Level Controller:
  1: Deployment:, 2. StatefulSet: 3. ReplicaSet:

*  NameSpace - namespace (better practice - assigning in a group )

* Nodeport - While using type Nodeport  the port range will be 3000-34000


```bash
 Test scenario
  When deleting one pod or multiple pods the control managers get reported by kubelet running on the worker node, then control manager sends info to API server and a request is sent to the worker node and  it will spin up the pods mentioned on yaml file, no interruption on the service. you can keep checking the browser if it's Apache or web servers.
  To completely kill/shutdown httpd, nginx - update yaml file replica 0 and apply, delete, or kubectl cmd.
```

* secrets and config maps ->  particular variable application then declare in config map. 
                            deployment is the desired state of the pod. attach config maps, all variables declare then will go to pods. 

* Everything is the manifest file in Kubnernetics desired state and yaml file

* pvc and pv storage classes - stateful(attach volume in pod) and stateless 


* helm (install, charts node js) - value. yaml value, template. helm install terraform or Prometheus or nginx etc, 

* Autoscaling - usage min replicas 1 max replicas 5
  
* service mesh 
   manage internal service  routing in Kubenetics cluster 
   service mesh all services talk to each other.



```bash
Must of the function with kubectl create, display, describe, set, edit, delete
```

* take etcd backup of recovery and restore - etcdctl cmd snapshot, etcdctl snapshot restore 


* high availability cluster
  3-5 control plane (master) - active, stand by standby. 6443 - etcd replication - specific port of other etcd can be reached data across on all dc. (API server) are stateles .. controller manager scheduler active and others stand by 
  they elect one master so they don't mess up. they don't work at the same time. 
  through LB they talk to Kublet. 

* EKS - on demand if the master goes down.

* 3a's of k8s security API server -> authentication -> authorization -> admission controller -> process request 

* role and role binding  user define, assign a role. 

* cluster role and cluster role binding  and cluster role and cluster role binding. 

* Deployment
 scaling -> replica set, rollout, and rollback 

* Application Deployment
  rollout, pause & resume, rollback.

* scaling
  replicas and scale up and down based on traffic 
    kubectl describes deploying Nginx | grep strategy 


  ```bash Zerotime deployment - 
   deployment strategy - scaling 
    recreate - V1 to V2 (downtime associated) - avoid 2 different version running, QA, deployment env
    rolling update - upgraded one at a time,  (it's default ) 25% deployment 
    canary deployment - upgrade one host and test and do on all.  advantage users get oppurtunity to roll out before the end, the slow rollout process
    blue/green - advantage, big cluster 

rollback - kubcetcl rollout undo deployment nginx-deploy --to-revision=1 ```

* --record - for history

* application upgrade
  imperative - cmd line
  declarative  - .yaml file

* kubectl rollout status or history 

* config maps 
  docker hub or Google container registry. 
  custom configs

* config maps creation by syntax and from file

* app images -> dev config -> dev
* app image  -> prod config -> prod


* node selector 
  like disk: ssd 

* resource - request, and limits
  cpu: "20m" memory: "100mu"


* seal-healing - if node or pod fails, it will not auto-generate, 
* manifest & templating 
  example namespace: dev, prod
         namespace: {{.Values.namesapace}}  or commonlabel: environment: production

* helm -package manager like yum in centos, called charts. 

* services and networking 
   Basic network terminology, Kubernetes cluster networking & ports,  CNI, connectivity between pod to pod/ container, services, DNS, service recovery, endpoint

* container network interface - node 1 to node 1 connection,  CNI plugins install
   pod-to-pod communication within the cluster, pod IP management gets unique ips. 
   weave (net) plugin, flannel, canal, calico, 


* services provide
 stable ip- dns-port , pods are scaled up and down
 it uses pod label to track pod status, and head and forward requests to app pod and db pods
 types; 3
    cluster IP (within the cluster) confined to cluster - within a cluster(DB), pod labels.
    node port - web application outside world creates service node port, external IP and port
    load balancer service - between pods, drawback(expensive) - increase cost. Ingres resources could be solutions


* kube proxy - agent like kublet, primary purpose, connection and perform LB. front end and backend, pods communicate through services, provide stable Ip and services. 

* kube proxy has iptables, node A to node B connection.  watches for newly created services and endpoints, it updated IP tables with new ports and IP addresses, making it routable in the new Kubernetes cluster. performs LB. 

* DNS in Kubernetes
   core DNS pods and kube DNS,   

* Service discovery - pods don't communicate using IP address. a pod is short-lived. pods use service objects to expose within and outside of the cluster. 
pobs labels to discovery from service labels.  consumer pod uses service discovery to connect to producer service.  
  service discovery -> env variables, DNS.  it will create DNS service ip on resolv. conf using dns name. pod to pod connection using DNS 

* Endpoint  (track IP address of pods that service sends traffic to. pod ip added to endpoint )
  frontend pod -> backend service -> backend pod
  backend service using labels and selectors to send traffic to backend pods
  kubectl get ep
  backend service have ips of backend pods
  kubectl get svc
  kubectl get ep
  kubectl get pods -o wide 


* pod to service communication

* pod communicate with services. 
 communication between pods on cross nodes - use CNI 
    node 1 -> 2 pod running -> eth001 -> bridge (subnet/netblock) -> iptables -> etho gateway ip -> CNI -> eth0 gateway ip - > bridge (net block) -> veth003 -> 2 pod -> node 2

* Internet to services -
   exposing the app to the internet
     - node port service - drawback pods are accessible to port 30124, if a node fails, then no service for a client. it is for testing and demos not for prod, node port open ports on * every node to internet security issues.  NO LB so traffic is directed to only one node. 
     - load balancer - spreading evenly across healthy node -> type: load balancer has external ip address. 
     - LB  - for each service can be expensive so it is better to use LB and ingress controller. 
     (single IP for all services -> ingres -> mycompany.com -> service -> pod
        - ingres controller provides host and path determines where it needs to send
           like -> mail.mycpmay.com or news.company.com  - news-service - new -service  etc

* ingress  controller -> reduces cost and saves time. 
          2 parts ingress controller - software application read -> ingress resource yaml file and routes traffic based on yml file. 

*  mail.mycompany.com -> LB (single external ip ) ->  ingress controller  -> notices mail.mycompany.com  rule is mapped to mail-service on ingress resource and fwd based on it. 
     ngnix -ingress controller -> deployment -> 1) deploying Nginx, namespace, config maps, roles and cluster roles, service accounts 
            ingress controller -> service -> exposing service LB 

* Configuring ingress controller. kubetctl get namespaces. installing using mandatory.yaml file.

 
* ingres rules -> 
         host 
           mail.mycomapny.com/inbox -> inbox-svc:80 (backend service and port)
           mail.mycomapny.com/sent -> set-svc:80
           mail.mycomapny.com/     -> mail-svc:80

           need to put paths in kind: Ingress  (define rule in ingress resource yaml)

* ingres resource -> 
             single service (LB) -> no rules just one like -> mail-svc -> pod
             Name-based virtual hosting -using hostname - multiple hosts using one IP using rules:
             using paths like /inbox or /sent etc and different port
    
*   Storage
     volume types
      temp - empty dir (pod get destroy data gets destroyed) and host path (data will be retained on host dir )
      persistent -  gce, AWS elastic block storage and azure
      network - nfs, iscsi, glusterfs
      config - config maps, secrets, downwardAPI

* pv and pvc -  Admins setups up persistent storage, admin creates PV, develops creates PVC (claim), creates pod with volume with pVC, others can't claim until pvc is deleted. 

* volume -> access mode -> Read write once, read only many, read write many 

* reclaim policies -  storage disk -> pv -> pvc -> pod, end of application life cycle, delete pod and pvc.  Reclaim -> retain even pvc delete, pv is there. need to delete 
     storage cloud storage and Pv as well. 
      delete -> Kubernetes automatically deletes pv and storage disk, after pvc gets deleted, delete is the default reclaim policy. 

* perssitent volumme -> PVC -> mount volume in pod. 
* storage class -> pv -> pvc -> storage class - dynamic . cloud  providers are standard, regular, and slower (hdd and ssd). Local we need to set up. 
* standard (default). neeed ssd then storageclassname: gold 
