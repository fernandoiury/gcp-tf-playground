#!/bin/bash
gcloud container clusters get-credentials fernando-tests-development-gke --region us-central1
kubectl config current-context | grep gke | grep fernando-tests &> /dev/null
if [[ $? -ne 0 ]]; then
  echo NOT fernando-tests... exiting
  exit 1
fi

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
sleep 30

helm install --name nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.publishService.enabled=true -f nginx.yaml
