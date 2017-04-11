#!/bin/bash
if [ -z "$AWS_ACCESS_KEY_ID" ]; then
    read -p "AWS_ACCESS_KEY_ID: " AWS_ACCESS_KEY_ID
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    read -p "AWS_SECRET_ACCESS_KEY: " AWS_SECRET_ACCESS_KEY
fi

oc create secret generic letsencrypt-aws --from-literal=AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID --from-literal=AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
oc create serviceaccount letsencrypt
oc apply -f .
oc adm policy add-cluster-role-to-user route-cert-controller system:serviceaccount:default:letsencrypt

#enable letsencrypt on your route
#oc annotate route/myapp openshift.catalysts.cc/letsencrypt=true
