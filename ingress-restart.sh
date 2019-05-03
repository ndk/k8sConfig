#!/bin/bash

#Always delete letsencrypt ingress:
echo " -> Deleting ingress-letsencrypt..."
microk8s.kubectl delete ingress ingress-letsencrypt

if [ $1 = "stop" ]; then
   #Delete ingress-fanout-auth: 
   echo " -> Deleting ingress-fanout-auth..."
   microk8s.kubectl delete ingress ingress-fanout-auth

   #Delete ingress-fanout-noauth:
   echo " -> Deleting ingress-fanout-noauth..."
   microk8s.kubectl delete ingress ingress-fanout-noauth
else
  #And update all changes:
  echo " -> Creating/updating ingress-noauth..."
  microk8s.kubectl apply -f ./ingress-noauth.yaml
  echo " -> Creating/updating ingress-auth..."
  microk8s.kubectl apply -f ./ingress-auth.yaml
fi

