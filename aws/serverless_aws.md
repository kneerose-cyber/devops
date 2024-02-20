**Serverless** 
1) monolith - single architecture (UI, backend, db, password and email, etc - tightly coupled) all services will go down if any changes.
2) microservices - amazon.com (frontend, backend, and db separate but communicate. ) - high scalable. 
3) serverless - don't have to manage to deploy the app and AWS takes care of scalable.

**serverless** framework
serverless.com 
serverless uses Cloudformation as infra as code. 


**CloudFormation** is tightly integrated with AWS and provides native support for AWS services, while **Terraform** offers multi-cloud support and a flexible, extensible language for defining infrastructure. 
The choice between them often depends on factors such as the specific cloud environment, existing skill sets, and project requirements.
Cloudformation - serverless uses cloud formation, including YAML and AWS libraries. 
CloudFormation is a service provided by AWS (Amazon Web Services) that allows you to define and provision AWS infrastructure as code using templates.
With CloudFormation, you can create and manage a collection of AWS resources consistently and predictably.

**Note** - To deploy the app serverless use  yaml, aws libraries, node js, etc

**Artitecture FLOW** - HQ (starting point - ec2 instance )-> cloud formation makes below infrastructure. IAM roles are needed. 
        User request -> API gateway -> lambda function -> code from s3 -> lambda function -> insert in dynamo db and retrieve from dynamo db 
          lambda -> logs to cloudwatch 

**steps** 
 ```
 1) create an ec2 instance on was (starting point to control the project)
 2) go to serverless.com (sign-up, will be required when using ec2 serverless to run on the serverless site.)
 3) click on setup and install serverless using npm install on created ec2 instances. 
    install node js, npm, and do serverless, might need to install nvm(fix node js version)
     npm install -g serveless
 4) now  setup cmd $serverless
                AWS - Python - HTTP API 
                framework - yes
                deploy - NO.

5) open the folder and check README.md, handler.py, serveless.yml  (events httpAPI) path: /hello   trigger website /hello trigger lambda function
6) serverless deployment ( it will fail, need to create IAM user -testing administrative access) create access key and now setup aws CLI setup - then $aws configure
7) now you can deploy serverless deploy 
8) go to serveless.com  go-to provider and aws provider (access/secret key)
9) now serverless deploy 
10) you should get endpoint https://*/hello (It sud return what lambda function had)
11) sls deploy cmd
12) serverless remove (to delete everything) ```

**play with yaml**, create 2 lambda functions, and do serverless deploy)
**practice/example **- website, look for examples and tutorials 

**project to practice**  creating Dynamo db, insert, delete, and update. 
**login to and check** cloud formation - stacks - view in designer (it will show an architecture diagram)



