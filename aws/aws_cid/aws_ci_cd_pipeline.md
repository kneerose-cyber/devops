AWS dev ops CI/CD.

**code **
    code pipeline -> commit -> build -> deploy 
    IAM KMS(service key management files encrypt/decrypt - secrets)
    Artifact(codd build storage ) S3 
    Ec2 ECS LAMBDA


**flow**
code -> code commit -> code build -> artifact, s3 -> code dpeloy -> (ec2, lamda, ecs)
code pipeline(ci/cd) -> source -> build -> deploy 

**practical**
 search -> code commit -> create repositories 
 IAM user, access console. httpd generates code commit.


```git clone  https://git-codecommit.us-east-2.amazonaws.com/v1/repos/demo-app```
```index.html 
<!DOCTYPE html>
<h1>My Demo app this is nice</h1>```

```git add index.html 
commit to the master branch, create a dev branch and commit, and in GUI create a pull request to 
merge to the master branch etc. ```
**approval** rule template - how many users need the approval to merge to the master


 1) ON AWS  create a build project 
 2)   buildspec.yml - IMP (stage and phases and config, write here to install etc.)
     version: 0.2
```
phases:
 install:
  commands:
    - echo Installing NGINX
    - sudo apt-get update
    - sudo apt-get install nginx -y
 build:
  commands:
    - echo Build started on `date`
    - cp index.html /var/www/html/
 post_build:
  commands:
    - echo configuring nginx

artifacts:
  files:
    - '**/*'
```
** commit the builspec.yml**( it will take it default) file and push to dev branch 
 3) now save the build project and click build, it should fail for the builspecs.yml file
 4) check phase details
 5) code commit to create a pull request to merge from dev to master the builspec.yml file.
 6) now re-run the build and should pass, it will create a docker container. it will be a success
 7)now create an s3 bucket to store artifacts
   Create a bucket and create the folder.
   edit the project artifacts
   s3 bucket (to store in a bucket ) - use the name of the bucket and folder created above.
   also, path go to s3 bucket-> folder-> copy the s3 URI and paste it on the path on edit artifacts
         save and run the build if failure check and fix permission on the IAM user
 8)deploy a server on the app  
 9) deploy - create application ec2 -> create deployment group (1)
10) App to deploy multiple servers or a server, you need a deployment group ```



**note** - code commit <connection need a service role> code build



**IMP** -
 1)create a role add below services
   AmazonEC2FullAccess	AWS managed	1
   AmazonEC2RoleforAWSCodeDeploy	AWS managed	1
   AmazonEC2RoleforAWSCodeDeployLimited	AWS managed	1
   AmazonS3FullAccess	AWS managed	2
   AWSCodeDeployFullAccess	AWS managed	1
   AWSCodeDeployRole	AWS managed	1
   AWSCodeDeployRoleForECS	AWS managed

 2) attach this role on service role on create deployment group(1) arn:aws:iam::592701661094:role/aws_code_deploy  
3) create ec2 instance and click on aamazon ec2 instance.  value add the ec2 hostname
  install aws code agent
  select -> never
  enable LB
   create deployment
```

a) why not install the aws code agent - the agent will install docker etc on ec2 instances, code deploy agent - needs to be in the ec2 instance. 
aws code deploy is not upgraded as it is ec2 so it's better to use ec2 and install the agent instead than going separately code deploy. 
b) code deploy version and ec2 code deploy agent version lot of mismatches
c) solution - shell scripy 
    In order to deploy your app to EC2, CodeDeploy needs an agent which actually deploys the code on your EC2.

      Create a shell script with the below contents and run it (install agent)

**make sure to edit east-1 or east 2 on the below script, depend your location **
    #!/bin/bash 
    # This installs the CodeDeploy agent and its prerequisites on Ubuntu 22.04.  
    sudo apt-get update 
    sudo apt-get install ruby-full ruby-webrick wget -y 
    cd /tmp 
    wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/releases/codedeploy-agent_1.3.2-1902_all.deb 
    mkdir codedeploy-agent_1.3.2-1902_ubuntu22 
    dpkg-deb -R codedeploy-agent_1.3.2-1902_all.deb codedeploy-agent_1.3.2-1902_ubuntu22 
    sed 's/Depends:.*/Depends:ruby3.0/' -i ./codedeploy-agent_1.3.2-1902_ubuntu22/DEBIAN/control 
    dpkg-deb -b codedeploy-agent_1.3.2-1902_ubuntu22/ 
    sudo dpkg -i codedeploy-agent_1.3.2-1902_ubuntu22.deb 
    systemctl list-units --type=service | grep codedeploy 
    sudo service codedeploy-agent status


the agent will run below/ 
    appspec.yml
     version: 0.0
     os: linux
     files:
       - source: /
         destination: /var/www/html
     hooks:
       AfterInstall:
          - location: scripts/install_nginx.sh
            timeout: 300
            runas: root
       ApplicationStart:
          - location: scripts/start_nginx.sh
            timeout: 300
            runas: root 

**scripts folder**
create below .sh files 
install_nginx.sh
  #!bin/bash
   sudo apt-get update
   sudo apt-get install -y nginx

start_nginx.sh
  #!bin/bash
   sudo service nginx start

Now commit the code on the master branch. 


note - The application to run in the ec2 server, needs config file name appspec.yml and needs to be stored on s3. code commit -> code build and send to -> s3. code deployment will be collected from s3. 

now run the build again after a successful

Now go to s3 to validate the zip file exists. #copy S3 URI

Developer Tools -> CodeDeploy -> Applications ->demo-app-application -> demo-app-deployment-group -> create deployment and revision location paste the s3 URI

now create deployment  
now this process begins when the code deploys it will collect code from s3 and send it to the ec2 instance.


Image steps workflow. 

1) ec2 -> s3 
2) ec2 -> code deploy

  a) make one more role for ec2-code-deploy add -> ec2 full access, s3 full access, full code deploy
  b) give the ec2 instance, security, modify iam roles, choose ec2-code-deploy, and update iam role.  
  c) in ec2 instance -> service codedeploy-agent restart (becoz of above permissions)
  d) check status now deployment status should succeed.  app will be deployed. 
  e) check URL on website index.html using ip address.
```
create pipeline
    source -> source provider(aws codecommit) -> repo name (demo-app) -> branch (master)
    select AWS codepipeline (any change on code commit repo and deploy in pipeline-polling)
    build stage -> build provde (aws code build) project name -> create earlier. 
    deploy -> codeDeploy -> demo-app 
    pipeline should be created and make sure no issues.
