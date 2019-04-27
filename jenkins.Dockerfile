FROM jenkins/jenkins:lts
#FROM jenkins/jenkins:lts-alpine

USER root
RUN apt-get update
RUN apt-get install -y curl software-properties-common
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs



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
