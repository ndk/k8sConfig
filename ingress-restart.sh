#!/bin/bash

#Delete letsencrypt ingress:
echo " -> Deleting ingress-letsencrypt..."
microk8s.kubectl delete ingress ingress-letsencrypt

#And update all changes:
echo " -> Creating/updating ingress-noauth..."
microk8s.kubectl apply -f ./ingress-noauth.yaml
echo " -> Creating/updating ingress-auth..."
microk8s.kubectl apply -f ./ingress-auth.yaml
