IAAS - infra as a service - hypversior(cloud)
PAAS - platform as service - docker -> ecs (platform to run application) - Amazon 
SAAS  softwate as service - insta, gmail.
Scalable, Elasticity.
Template -Launch instance from template, many templates.
Autoscaling group -> launch template -> attach LB (NLB or ALB) -> max running ec2(scaling).
AWS WAF (web application firewall ) -> Web ACLS ruless -> LB 
s3 bucket - objects(files, mp3, jpg, images ) - s3 is service, you can make bucket store files and retrieve. shared bucket. 
s3 bucket - json code using policy and index.html/ , access through url. - bucket policy. 
IAM - identitfy access management, access grants, user, roles , policicies. 
AWS CLI - access key and secret - view bucket, create eks, controll by IAM but access on almost many things to run container, terraform etc.
RDS- (relational database service) 
Dyanamo DB -  templates - create DB and create ec2 isntance. 
ec2 -  instance as client and connect to mysql DB  (ON db aws select ec2 instance for connections - it will create virtual private cloud. )
No sql - not only sql - dynamo DB - even proper schema not here it will work, it just need proper key. 
