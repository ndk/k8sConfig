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
#RUN apt-cache search docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN cat /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli
#it is very important to adjust the container docker's gid to be the same as the host docker gid
#RUN useradd ehynes -u 1001
#RUN usermod -u 1001 jenkins
#RUN groupmod -g 115 docker 
RUN usermod -aG docker jenkins
#RUN usermod -aG docker ehynes
#RUN usermod -aG docker $(id -un)
# affects the current shell, logging out should affect all shells
#RUN newgrp docker
#RUN apt-get remove -y  docker docker.io runc
#RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
#RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
#RUN apt-get update
#RUN apt-get install -y docker-ce
#RUN service docker start


# if we want to install via apk
#USER root
#RUN apk add docker openrc
#RUN addgroup jenkins docker
#RUN rc-update add docker boot

# drop back to the regular jenkins user - good practice
USER jenkins
