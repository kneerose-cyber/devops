Docker is virtualization software.  Make developing and deploying application much easier.
Docker user host kernel docker engine and give to container and it talks to hardware. 
docker
 virtualization, lightweight, reusuability

Hardware -> ram disk, network -> OS -> docker engine(docekr d, docker cli)  -> container have kernels (hardware access)
docker don't have kernel, it uses host kernel.

Docker d(deamon process) &  docker cli (cmd) 

Docker engine - Containter d (open source) is running on docker engine .  Docker uses containerd internally as the lower-level container runtime.

Docker images much smaller.  Containers take seconds to start.  Use host kernel so faster. 
Linux based docker images cannot use windows kernel . 
Most containers are linux based and built for linux. 

Docker images vs containers. 

Docker image  an executable applicaton artifacts, includes app source condes but also complete env config. 
Appliation -> js app, any services needed node, npm, os layer linux,   (image)

docker container - download image and run the application when we run image the app on the OS that gives container, running intance of an image. Same image you can run multiple containers. 


Registry vs repository 
  docker registry - service providing storage, collection od repositories 
  docker repository - collection  of related images with same name but different versions
 
Docker hub is registry - hub you can host provate or public repo for your application

Companies create custom images for their application
Dockerfile - is txt document that conatains command to asembel an immage,
Docketfile -> build-> image-> run-> container. 
file-> image -> container


Cons
-------
Don't have autohealing or scaling  & image build for one specific OS and can't be used on another. 


<kbd>![image](https://github.com/kneerose-cyber/devops/blob/main/docker/architecture.png)</kbd>

<kbd>![image](https://github.com/kneerose-cyber/devops/blob/main/docker/taxonomy-of-docker-terms-and-concepts.png)</kbd>

