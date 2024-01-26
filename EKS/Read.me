Elastic Kubernetes Service
   - Managed by AWS,
   - AWS VPC  (COntrol plane (shcheduler, api server, controller manager, etcd) ) - amazon create a control plane
   - Customer VPC (EKS managed ENi) - worker nodes(ec2 instances) -> LB -> customer 
   - noge group - number of servers 

```bash

IAM
Create a user “eks-admin” with AdministratorAccess
Create Security Credentials Access Key and Secret access key 

EC2

Create an ubuntu instance (region us-west-2)

ssh to the instance from local

Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin --update

Setup your access for IAM user to communicate with aws API.  keep access key and secret 


aws configure

Install kubectl

curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client



Install eksctl

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

Setup EKS Cluster


eksctl create cluster --name my-cluster --region us-west-2 --node-type t2.medium --nodes-min 2 --nodes-max 2
aws eks update-kubeconfig --region us-west-2 --name my-cluster
kubectl get nodes
kubectl get pods
kubectl get namesapce
kubectl get pods -n kube-system


Run Manifests

kubectl create namespace two-tier-ns

# run any app and check application is running.

# clone or run the httpd on eks cluster  https://github.com/kneerose-cyber/devops/tree/main/kubernetes/httpd_install

kubectl apply -f .
kubectl delete -f .


eksctl delete cluster --name my-cluster --region us-west-2

```


