#docker build
PS C:\workspace\gradle\docker> docker build -t docker-app .

#docker execute
PS C:\workspace\gradle\docker> .\docker-run.bat

#Jenkins with Nexus
docker run -d   --name jenkins   -p 8083:8080 -p 50000:50000   -v jenkins_home:/var/jenkins_home   -v /var/run/docker.sock:/var/run/docker.sock   jenkins/jenkins:lts
docker run -d --name jenkins   -p 8083:8080   -v /var/run/docker.sock:/var/run/docker.sock   -v jenkins_home:/var/jenkins_home   jenkins/jenkins:lts
docker exec -it jenkins bash
apt-get update
apt-get install -y docker.io
groupadd docker
usermod -aG docker jenkins
docker restart jenkins
docker exec -it jenkins bash
groups jenkins

root@8161d674130b:/# docker exec -u 0 -it jenkins bash
root@8161d674130b:/# usermod -aG docker jenkins
root@8161d674130b:/# chown root:docker /var/run/docker.sock
root@8161d674130b:/# chmod 664 /var/run/docker.sock
root@8161d674130b:/# exit
exit
PS C:\WINDOWS\system32> docker restart jenkins
jenkins
PS C:\WINDOWS\system32> docker exec -it jenkins bash
jenkins@8161d674130b:/$ docker ps
CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         PORTS                                                                                      NAMES
8161d674130b   jenkins/jenkins:lts   "/usr/bin/tini -- /u…"   3 minutes ago   Up 9 seconds   0.0.0.0:50000->50000/tcp, :::50000->50000/tcp, 0.0.0.0:8083->8080/tcp, :::8083->8080/tcp   jenkins
f4910a06f26e   sonatype/nexus3       "/opt/sonatype/nexus…"   3 hours ago     Up 3 hours     0.0.0.0:8082->8081/tcp, :::8082->8081/tcp                                                  nexus



넥서스 admin 패스워드 변경 -> Geometic7!

docker exec -u 0 -it jenkins bash
echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
docker exec -it jenkins bash
sudo whoami