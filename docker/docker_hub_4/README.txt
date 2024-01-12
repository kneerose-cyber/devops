hub.docker.com - create account and post image there

docker tag local-image:tagname new-repo:tagname
docker push new-repo:tagname 

#make sure you have a build image 
docker image

docker login

docker tag java-app:latest kneerose/node-app:latest

docker push kneerose/node-app:latest

#info - need to stop container before docker kill containterID, docker prune deadcontainer, remove stop container, docker system prune(risky cmd)
#delete imgage id
docker rmi IMAGEID

# now pull your image that you pushed on hub.docker.com
docker run -d kneerose/node-app:latest
