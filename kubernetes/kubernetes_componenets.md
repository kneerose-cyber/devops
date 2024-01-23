
* monolith -  whole application running on one sever, application deployed as single unit, tighy coupled, if the host goes down all application is down or even break fix/upgrade it might take whole application down until it's clustered env.

* micro services -  small independent services communicate each other using APIs and loosely coupled, for example facebook messanger and feed might be running on different servers so only 1 service will be impacted(meaning feed down) instead of whole application going down.

* pods vs container -  pods is the smallest unit in kubernetics and can host multiple containers in a pod but it is recommened to do 1 pod = 1 container.  Container is isolated and executable software package like nginx, httpd etc. Pods are useful for scenarios where containers need to share resources, such as network or storage, and are deployed and scaled together.

* config - to run container (yaml file) manifest (deisred state) , nginx container etc, ENV variable, it will create pod on worker node

* labels (selector or selecting criteria) - is identificaiton give to pod to match desire state

* selectors are criteria where you're matching.
* service
    node font, cluster ip and load balancer 

* autohealing - try to delete pod and app wont stop within a second scheduler gets inform, schedule send request to create new pod,  


* Pods without a Higher-Level Controller:
  1: Deployment:, 2. StatefulSet: 3. ReplicaSet:

*  NameSpace - namesspace (better practice - assigning in a group )

* Nodeport - While using type Nodeport  the port rande will be 3000-34000 range


```bash
 Test scenario
  When deleting one pod or multiple pods the control managers get reported by kubelet running on worker node, then control manager send info to api server and request is sent to worker node and  it will spun up the pods mentioned on yaml file, no interruption on the service. you can keep checking the browser if it's apche or web servers.
  To completely kill/shutdown httpd, nginx - update yaml file replica 0 and apply, delete or kubectl cmd.
```

* secrets and config maps ->  particualr variable application then declre in config map. 
                            deployment is desired state of pod. attach config maps, all variable declare then will go to pods. 

* Everything is manifest file in kubnernetics desired state and yaml file

* pvc and pv storage clasess - statefull(attach volume in pod) and stateless 


* helm (install, charts node js) - value . yaml value , template. helm install terraform or prometheus or nginx etc , 

* Autoscaling - usage min replicas 1 max replicas 5
  
* service mesh 
   manage internal service  routing in kubenetics cluster 
   service mesh all service talk to each other.



```bash
**Must of the function with kubectl create, display, describe, set, edit, deleted** 
```

* take etcd backup of recovery and restore - etcdctl cmd snapshot , etcdctl snapshot restore 


* high availability cluster
  3-5 control plane (master) - active, stand by standby. 6443 - etcd replication - specific port of other etcd can be reached data across on all dc. (api server) are stateles .. controller manager schduel active active and other standy by 
  they elect one master so they don't mess up. they don't work at same time. 
  through LB they talk to Kublet. 

* EKS - on demand if master goes down.

* 3a's of k8s security API server -> authentication -> authorization -> admission contreoller -> process request 

* role and role binding  user define, assign a role. 

* cluster role and cluster role binding  and cluster role and cluster role binding. 

* Deployment
 scaling -> replica set, rollout, and rollback 

* application Deployment
  rollout, pause & resume, rollback.

* scaling
  replicas and scale up and down based on traffic 
    kubectl describe deploy neginx | grep stragety 


  ```bash Zerotime deployment - 
   deployment strategy - scaling 
    recrete - V1 to V2 (downtime assocaited) - avoid 2 adifferent version running, qa, deployment env
    rolling update - upgraded one at a time,  (it's default ) 25% deployment 
    canary deployment - upgrade one host and test and do on all.  advantage user get oppurinity to roll out before end, slow rollout process
    blue/green - advantage, big cluster 

rollback - kubcetcl rollout undo deployment nginx-deploy --to-revision=1 ```

* --record - for history

* application upgrade
  imperative - cmd line
  delcarative  - .yaml file

* kubectl rollout status or history 

* config maps 
  docker hub or google container registry. 
  custom configs

* config maps creation by syntax and from file

* app images -> dev config -> dev
* app image  -> prod config -> prod


* node selector 
  like disk : ssd 

* resource - request and limits
  cpu: "20m" memory: "100mu"


* seal-healing - if node or pod fails, it will not auto-generate, 
* manifest & templating 
  example namespace: dev, prod
         namespace: {{.Values.namesapace}}  or commonlabel: environment: production

* helm -package manager like yum in centos, called charts. 

* services and networking 
   Basic network terminology, kubenetes cluster networking & ports,  CNI, connectivity between pod to pod/ container, services, DNS, service recovery, endpoint

* container network interface - node 1 to node 1 connection,  CNI plugins install
   pod to pod communication within cluster, pod ip management get unique ips. 
   weave (net) plugin, flannel, canal, calico, 


* services provide
 stable ip- dns-port , pods are scaled up and down
 it uses pod label tor track pod status, head and forward request to app pod and db pods
 types; 3
    cluster IP (within the cluster) confine to cluster - within a cluster(DB), pod labels.
    node port - web application outside world create service nodeport, external ip and port
    load balancer service - between pods, drawback(expensive) - increase cost. ingres resource could be solutions


* kube proxy - agent like kublet, primary purpose, connection and perform LB. front end and backend , pods communicate through services, provides stable Ip and services. 


* kube proxy have iptables, node A to node B connection.  watches for newly created services and end points, it updated ip tables with new port and ip address, making it routable in new kubenetics cluster. performs LB. 

* DNS in kubernetes
   coreDNS pods and kube DNS,   



* Service discovery - pods don't communicate using ip address. pod is short lived. pods uses service object to expose within and outside of cluster. 
pobs labels to dsicovery from service labels.  consumer pod uses service dicovery to connect to producer service.  
  service discovery -> env variables, DNS.  it will create DNS servie ip on resolv.conf using dns name. pod to pod connection using DNS 

* Endpoint  (track ip address of pods that service sned traffic to. pod ip added to endpoint )
  frontend pod -> backend service -> backend pod
  backend service using labels and selectors to send traffic to backend pods
  kubectl get ep
  backend service have ips of backend pods
  kubectl get svc
  kubectl get ep
  kubectl get pods -o wide 


* pod to service communication

* pod communicate with services. 
 communication between pods ona cross nodes - use CNI 
    node 1 -> 2 pod running -> eth001 -> bridge (subnet/net block) -> iptables -> etho gayteway ip -> CNI -> eth0 gateway ip - > brdieg (net block) -> veth003 -> 2 pod -> node 2

* interenet to services -
   exposing app to internet
     - node port service - drawback pods are accesible to port 30124, if node fails, then no service fir cleint. it is for testing and demos not for prod, node port open ports on * every node to internet security isssues.  NO LB so traffic is directd to only one nodes. 
     - load balancer - spreading evenly across healthy node -> type: loadbalancer have external ip address. 
     - LB  - for each service can be expensive so it better to use LB and ingress controller. 
     (single ip for all services -> ingres -> mycompany.com -> service -> pod
        - ingres controller provides host and path determines where it needs to send
           like -> mail.mycpmay.com or news.company.com  - news-service - new -service  etc

* ingress  controller -> reduces cost and saves times. 
          2 parts ingress controller - software application read -> ingress resource yaml file and routes traffic based on yml file. 

*  mail.mycompany.com -> LB (single external ip ) ->  ingress controller  -> notices mail.mycompany.com  rule is mapped to mail-service on ingress resource and fwd based on it. 
     ngnix -ingrs controller -> deployment -> 1) deploying nginx, namssapce, configmaps, roles and cluster roles, service accoutns 
            ingrs controller -> service -> exposing service LB 

* configurating ingress controller. kubetctl get namspaces. installing using mandatory.yaml file.

 
* ingres rules -> 
         host 
           mail.mycomapny.com/inbox -> inbox-svc:80 (backend service and port)
           mail.mycomapny.com/sent -> set-svc:80
           mail.mycomapny.com/     -> mail-svc:80

           need to put paths in kind: Ingress  (define rule in ingress resouce yaml)

* ingres resouce -> 
             single service (LB) -> no rules just one like -> mail-svc -> pod
             Name-based virtual hosting -using hostname - multiple host using one IP using rules:
             using paths like /inbox or /sent etc and different port
    
*   Storage
     volume types
      temp - empty dir (pod get destroy data gets destroyed) and host path (data will be retein on host dir )
      persistent -  gce, awselastic block storage and azure
      network - nfs, iscsi, glusterfs
      config - config maps, secrets, downwardAPI

* pv and pvc -  Admins setups up persisten stiorage, admin create PV, develips creates PVC (claim) , creates pod with colume with pVC, other can't claim until pvc is deleted. 

* volume -> access mode -> Read write once , read only many, read write many 

* reclaim policies -  storage disk -> pv -> pvc -> pod , end of application life cycle, delete pod and pvc .  Reclaim -> retain even pvc delete, pv is there. need to delete 
     storage cloud storage and Pv as wlel. 
      delete -> kubenetes autmatically delete pv and storage disk, after pvc gets delete, delette is defualt recliam policy. 

* perssitent volumme -> PVC -> mount volume in pod. 
* storage class -> pv -> pvc -> storage class - dynamic . cloud  providerhave standard, regular and slower (hdd and ssd) . Local we need to setup. 
* standard (default). neeed ssd then storageclassname: gold 
