Troubleshooting

**Monitoring:**
  reliability, insights, cost control -  componeent health status, cpu, memeory, usage, network, application metrics. 

  Built in - cAdvisor (cpu, memory usage, from containers) each kubelet contains. 
  Metric Server - stable Ip address, colleced data from cAdvisor and expose single location.
  k8 dashboard for visual represetation , kube state metrics - cpu, memory, network. 
  Probes - health status of container and pod, sometime take out pod/container and fix. 

**open source** - prometheus, grafana, elk stack, kubewatch, weave scope.
**paid** - datadog, appdynamics.

**data source** (container run time, pods, kubenetes, nodes ) - > aggregrator (prometheus, metrics server) -> storage (influx db, promethus time series db) -> visualization(grafana, k8 dashboard)

**Logs**  -> data source (logs) -> aggregrator -> DB -> visualization


**troubleshooting**
  **pods**-  kubectl get pods, kubectl describe pods [pod_name]
      pending - Not enough resource, fix - deleted pod and add new
      waiting - incorrect image, does images exists in repo. fix - run manual docker pull on worker node to check if image can be pull.
      crashback or unhealthy - logs of pods and containers. kubectl exec podname -- cmd arg1
      running, but not doing as expected -  kubectl apply --validate -f mypod.yaml

   **replica set**  - 
       kubectl describe rs [replicaSet_name]
       
   **services** - 
      selector using correct pod name, kubectl describe service [service_name] , kubectl get endpoints [service_name] , kubectl get pods --selector=run=nginx
    **Cluster**
           kubectl get nodes
           kubectl describe node [node_name]
           kubectl cluster-info
           kubectl get componentstatus      
    **Logs**
         kubectl logs api server, schedule, controller manage, etcd. 
         manual - cat /var/log/
    **Services** - kubeadm services
            kubectl get pods -n kube-system
            systemctl kubelet, docket, api-server, schedulet. manager, etcd. 
     **troubleshooting worker node**-
             kubectl get nodes
                issue could be - disk, network, kubelet, memory
              kubectl describe node worker-1
                 check - docker status, kubelet, top, df -h, free 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Metrics Server is responsible for gathering resource usages.
***************************************************************************************************
***************************************************************************************************
***************************************************************************************************
***************************************************************************************************
***************************************************************************************************


0. Pre-Req:
-----------
Check if your cluster is running with MetricsServer by running following commands

kubectl top nodes

kubectl top pods

kubectl get pods -n kube-system | grep -i metrics

If not, go ahead with below steps. 


***************************************************************************************************

1. Download:
------------

git clone https://github.com/kubernetes-sigs/metrics-server.git


***************************************************************************************************

2. Installing Metrics Server:
-----------------------------

kubectl apply -k metrics-server/manifests/test

Give it a minute to gather the data and run this command.

kubectl get pods -n kube-system | grep -i metrics

-----------------
# Troubleshooting:

If you encounter any Image error, try updating imagePullPolicy from "Never" to "Always
in metrics-server/manifests/test/patch.yaml

kubectl delete -k metrics-server/manifests/test

vim metrics-server/manifests/test/patch.yaml
#Then update "imagePullPolicy" from "Never" to "Always" - imagePullPolicy: Always  

kubectl apply -k metrics-server/manifests/test

kubectl get pods -n kube-system | grep -i metrics


***************************************************************************************************

3. Validate:
------------

kubectl get deployment metrics-server -n kube-system 
kubectl get apiservices | grep metrics
kubectl get apiservices | grep metrics
kubectl top pods
kubectl top nodes

Note: Give it a minute if nothing shows up in top command output. 


***************************************************************************************************
***************************************************************************************************
***************************************************************************************************
***************************************************************************************************
***************************************************************************************************

NOW BEFORE YOU RUN:
-------------------
a. "kubectl top" command plays important role in monitoring Pods and containers resources such as CPU and Memory.
b. To run "kubectl top..." we need to INSTALL "Metrics Server" on K8s cluster


***************************************************************************************************

0. PRE-REQ: Installing Metrics-Server (Required for "kubectl top" command)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a. Download 
------------
git clone https://github.com/kubernetes-sigs/metrics-server.git


b. Install 
-----------
kubectl apply -k metrics-server/manifests/test


c. Validate 
------------
kubectl get deployment metrics-server -n kube-system 
kubectl get pods -n kube-system | grep metrics
kubectl get apiservices | grep metrics
kubectl top pods
kubectl top nodes

Note: Give it a minute if nothing shows up in top command output.



***************************************************************************************************


1. NODEs: Ensure all nodes are "Healthy" and "Ready". Monitor its resource usage (CPU & Memory):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

kubectl run nginx-pod --image=nginx
kubectl run redis-pod --image=redis

kubectl top nodes
kubectl top nodes --sorty-by cpu
kubectl top nodes --sorty-by memory
kubectl top nodes --sorty-by memory > mem-out.txt


***************************************************************************************************


2. PODs: Ensure all Pods are "Running" successfully and Monitor its resource usage (CPU & Memory):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Current Namepsace:
---------------------
kubectl top pods
kubectl top pods --sorty-by cpu
kubectl top pods --sorty-by memory
kubectl top pods --sorty-by memory > mem-out.txt

In Specific NameSpace:
----------------------
kubectl top pods -n [NAME-SPACE]
kubectl top pods -n [NAME-SPACE] --sorty-by cpu
kubectl top pods -n [NAME-SPACE] --sorty-by memory
kubectl top pods -n [NAME-SPACE] --sorty-by memory > mem-out.txt

In Across Namespaces:
---------------------
kubectl top pods -A
kubectl top pods -A --sorty-by cpu
kubectl top pods -A --sorty-by memory
kubectl top pods -A --sorty-by memory > mem-out.txt

When Multi-Cotinaer Pod:
------------------------
kubectl top pod [POD-NAME] --containers



***************************************************************************************************


3. Cluster Compoents: Ensure all K8s Cluster Components are "Healthy" and "Running" status:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If Cluster configured with "Kubeadm"
------------------------------------
kubectl get pods -n kube-system   


If cluster configured Manually (the hard-way)
---------------------------------------------
systemctl status kube-apiserver  
systemctl status kube-controller-manager
systemctl status kube-scheduler


Ensure, following components are in "Running" status on all nodes including Master(Control-Plane) node.
------------------------------------------------------------------------------------------------------
systemctl status docker
systemctl status kubelet


***************************************************************************************************
***************************************************************************************************
***************************************************************************************************
***************************************************************************************************
***************************************************************************************************
***************************************************************************************************
***************************************************************************************************
***************************************************************************************************

1. Troubleshooting Cluster and Nodes:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Check:
------
kubectl get nodes
kubectl top node 


Possible Solutions:
-------------------
Please refer to below link for more details.
https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster/


***************************************************************************************************


2. Troubleshooting Components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2a. If cluster configured with "kubeadm"
-------------------------------------------

Check:
------
kubectl get pods -n kube-system
systemctl status kubelet
systemctl status docker

Troubleshoot:
-------------
kubectl logs kube-apiserver-master -n kube-system
kubectl logs kube-scheduler-master -n kube-system
kubectl logs kube-controller-manager-master -n kube-system
kubectl logs etcd-master -n kube-system

Possible Solutions(NOTE: Does not covered all):
-----------------------------------------------
Kubelet:
systemctl enable kubelet  #Run it on all nodes (Including worker nodes)
systemctl start kubelet   #Run it on all nodes (Including worker nodes)

Docker:
systemctl enable docker   #Run it on all nodes (Including worker nodes)
systemctl start docker    #Run it on all nodes (Including worker nodes)


===================================================================================================


2b. If cluster configured with "Manual (Hard-way)"
-----------------------------------------------

Check
-----
systemctl status kube-apiserver
systemctl status kube-controller-manager 
systemctl status kube-scheduler 
systemctl status etcd

systemctl status kubelet # Run it on all nodes (Including worker nodes)
systemctl status docker  # Run it on all nodes (Including worker nodes)


Troubleshoot
------------
journalctl –u kube-apiserver 
journalctl –u kube-scheduler
journalctl –u etcd
journalctl –u kube-controller-manager 
journalctl –u kube-proxy
journalctl –u docker
journalctl –u kubelet


Possible Solutions(NOTE: Does not covered all):
------------------------------------------------
systemctl enable kube-apiserver kube-controller-manager kube-scheduler etcd
systemctl start kube-apiserver kube-controller-manager kube-scheduler etcd

Kubelet:
systemctl enable kubelet  #Run it on all nodes (Including worker nodes)
systemctl start kubelet   #Run it on all nodes (Including worker nodes)

Docker:
systemctl enable docker   #Run it on all nodes (Including worker nodes)
systemctl start docker    #Run it on all nodes (Including worker nodes)


***************************************************************************************************


