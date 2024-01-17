CI/CD
 code test and build and delivery/deploy 
 Declarative pipelines provide more structured and approach to  defining pipelines
 Blue ocean providing graphical visualization of pipeline execution.
 Jenkins written java

Jenkins master triggers run on  QA
                                UAT
                                prod servers

MAster and AGent 
ssh-keygen deploy on agent and on jenkins GUI add private keys to triggers build on agents.  
-------------------------------------------------------------------------------------------------------

**Update the system & install JENKINS**
```bash
sudo apt-get update
sudo apt install fontconfig openjdk-17-jre


sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update

sudo apt-get install jenkins
```

Install jenkins on ubuntu google
https://www.jenkins.io/doc/book/installing/linux/

jenkins --version
systemctl status jenkins
  by default jenkins run on 8080 and it get enable by default. allow 8080 on FW 

  <kbd>![image](https://openterprise.it/wp-content/uploads/2020/10/jenkins_pipeline.png)</kbd>


