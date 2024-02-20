AWS dev ops CI/CD.

code 
    code pipeline -> commit -> build -> deploy 
    IAM KMS(service key management files encrypt/decrypt - secrets)
    Artifact(codd build storage ) S3 
    Ec2 ECS LAMBDA


flow
code -> code commit -> code build -> artifact, s3 -> code dpeloy -> (ec2, lamda, ecs)
code pipeline -> source -> build -> deploy 


practical
 search -> code commit -> create repositories 
 IAM user , access console. httpd geenrate code commit.


git clone  https://git-codecommit.us-east-2.amazonaws.com/v1/repos/demo-app

index.html 
<!DOCTYPE html>
<h1>My Demo app this is nice</h1>

git add index.html 
commit to master branch, create dev branch and commit and in GUI create pull reques to 
merge to master branch etc. 
approval rule template - how many users need approval to merge to master. 


 create build project 


 buildspec.yml - IMP (stage and phases and config, write here to install etc.)
version: 0.2

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

 commit the builspec.yml( it will take it default) file and push to dev branch 
 now save the build project and click build , it should fail for builspecs.yml file
 check phase details

code commit create pulll request to merge from dev to master the builspec.yml file.

now re run build and should pass, it will create docker container. 
it will be success

now create s3 bucket to store artificats
  creat bucket and create folder .
edit the project artifcats
  s3 bucket (to store in a bucket ) - use the name of bucket and folder create above.
   also path go to s3 bucket-> folder-> copy s3 uri and paste it on path on edit artifcats
         save and run the build if failure check and fix permission on IAM user


 deploy server on app
deploy - create application ec2 -> create deployment group (1)
App to deploy multiple servers or a server, you need a deployment group 



note - code commit <connection need a service role> code build



create a role add below services
AmazonEC2FullAccess	AWS managed	1
AmazonEC2RoleforAWSCodeDeploy	AWS managed	1
AmazonEC2RoleforAWSCodeDeployLimited	AWS managed	1
AmazonS3FullAccess	AWS managed	2
AWSCodeDeployFullAccess	AWS managed	1
AWSCodeDeployRole	AWS managed	1
AWSCodeDeployRoleForECS	AWS managed

attach this role on service role on create deployment group(1) arn:aws:iam::592701661094:role/aws_code_deploy  

create ec2 instance and click on aamazon ec2 instance.  value add the ec2 hostname
installaws code agent
 select * never
 enable LB
create deployment


why not install awc code agent - agent will install docker etc on ec2 instances, code deploy agent - it needs to be in ec2 instance. 
aws code deploy is not upgrade as it is ec2 so it's better to use ec2 and install the agent instead than going seperately code deploy. 

code deploy version and ec2 code deploy agent version lot of mismatches

solution - shell script

Its easy :)
I got many errors while doing this, so here's a blog for setting up things in an easy way

In order to deploy your app to EC2, CodeDeploy needs an agent which actually deploys the code on your EC2.

So let's set it up.

Create a shell script with the below contents and run it (install agent)

make sure to edit east-1 or east 2 on the below script, depend your location
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


agent will run below/ 

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

scripts folder
install_nginx.sh
  #!bin/bash
   sudo apt-get update
   sudo apt-get install -y nginx

start_nginx.sh
  #!bin/bash
   sudo service nginx start


now commit the code on master branch. 


note - Application to run in ec2 server, need config file name appspec.yml and need to be store on s3. code commit -> code build and send to -> s3. code deploy will collect from s3. 

now run the build again after successfull

now got to s3 to validate the zip file exists. #copy S3 URI

Developer Tools -> CodeDeploy -> Applications ->demo-app-application -> demo-app-deployment-group -> create deployment and revision location paste the s3 URI

now create deployment  
now this process began when code deploy ill collect code from s3 and send to ec2 instance.


IMage steps work flow. 

1) ec2 -> s3 
2) ec2 -> code deploy

make one more role for ec2-code-deploy add -> ec2 full access, s3 full acess, full code deploy


give the ec2 instance, security, modify iam roles, chose ec2-code-deploy and update iam role. 

in ec2 instance -> service codedeploy-agent restart (becoz of above permissions)
check status

now deplopyment status should succeed.  app will be deployed. 

chec url on website index.html using ip address.


now 
create pipeline
    source -> source provider(aws codecommit) -> repo name (demo-app) -> branch (master)
    select AWS codepipeline (any change on code commit repo and deploy in pipeline-polling)

    build stage -> build provde (aws code build) project name -> create earlier. 

    deploy -> codeDeploy -> demo-app 

    pipeline should be created and make sure no issues .
