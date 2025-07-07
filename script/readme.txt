#docker build
PS C:\workspace\gradle\docker> docker build -t docker-app .

#docker execute
PS C:\workspace\gradle\docker> .\docker-run.bat

docker run -d --name jenkins   -p 8083:8080   -v /var/run/docker.sock:/var/run/docker.sock   -v jenkins_home:/var/jenkins_home   jenkins/jenkins:lts
docker exec -u root -it 3cfb21170b57150f9a968a9961ee42639eae3100f4bcf9713eb3879acf118aac bash