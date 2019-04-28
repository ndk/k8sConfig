# build with:
# docker build -t localhost:32000/jenkins-with-docker -f jenkins.Dockerfile .

# push with:
# docker push localhost:32000/jenkins-with-docker

FROM jenkins/jenkins:lts
#FROM jenkins/jenkins:lts-alpine

USER root
RUN apt-get update

# Prerequisites:
RUN apt-get install -y curl software-properties-common telnet zip vim

# Install node and npm:
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs

# Adding Docker:
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN cat /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli
#it is very important to adjust the container docker's gid to be the same as the host docker gid
RUN usermod -aG docker jenkins

# drop back to the regular jenkins user - good practice
USER jenkins
