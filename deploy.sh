#!/bin/bash

PROJECT_ID="xxxx" # Replace xxxx with your ID
REGION="europe-west1"
CLUSTER_NAME="xxxx" # Replace xxxx with your cluster name

# Configure Kubernetes credentials
gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION --project $PROJECT_ID

# Apply Kubernetes manifests
kubectl apply -f kubernetes-manifests/.
