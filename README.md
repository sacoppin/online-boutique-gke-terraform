# Online Boutique DevOps Implementation Challenge

A cloud-native microservices demo application deployed on Google Cloud Platform using Infrastructure as Code (Terraform) and following DevOps best practices.

## Challenge Overview

This project implements the **Online Boutique** - a 10-tier microservices e-commerce application where users can browse items, add them to cart, and make purchases. The solution demonstrates enterprise-grade cloud architecture with proper networking, security, and operational practices.

## Architecture & Requirements

### Network Design (Precision CIDR Allocation)
- **GKE Nodes**: `10.0.0.0/16` - Worker node IP range
- **Pods**: `10.1.0.0/16` - Container IP allocation  
- **Services**: `10.2.0.0/16` - Service discovery range

### Security Principles
- **Least Privilege Access**: Minimal IAM permissions per service account
- **Role Separation**: Different access levels for infrastructure vs application teams
- **Workload Identity**: Secure pod-to-GCP service communication

## Repository Structure

```
├── README.md                    # Project documentation
├── deploy.sh                    # CI/CD simulation script
├── kubernetes-manifests/        # Application deployment files
│   └── microservices-demo.yaml # Online Boutique K8s resources
├── main.tf                      # Core Terraform configuration
├── outputs.tf                   # Infrastructure outputs (IPs, endpoints)
├── variables.tf                 # Input variable definitions
└── versions.tf                  # Provider version constraints
```

## Quick Start

### Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) >= 1.5
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) 
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

### 1. Authentication & Setup
```bash
# Authenticate with Google Cloud
gcloud auth login
gcloud auth application-default login

# Set your project (replace with your project ID)
gcloud config set project YOUR-PROJECT-ID
```

### 2. Configure Infrastructure Variables
```bash
# Copy the example file and configure your values
cp terraform.tfvars.example terraform.tfvars

# Edit with your specific values
nano terraform.tfvars
```

**Example terraform.tfvars:**
```hcl
project_id = "your-gcp-project-id"
region     = "europe-west1"  # Default region (can be changed)
```
Note: Only project_id is required. The region defaults to europe-west1 but can be overridden.

### 3. Deploy Infrastructure
```bash
# Initialize Terraform
terraform init

# Review planned changes
terraform plan

# Apply infrastructure
terraform apply
```

### 4. Deploy Application (CI/CD Simulation)
```bash
# Make deployment script executable
chmod +x deploy.sh

# Deploy the microservices
./deploy.sh
```

### 5. Access Your Application
```bash
# Get the external IP of the frontend service
kubectl get service frontend-external

# Or use this one-liner to get just the IP
kubectl get service frontend-external -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
```

## Terraform Configuration Overview
# VPC with custom subnets
```bash
resource "google_compute_network" "vpc" {
  name                    = "boutique-vpc"
  auto_create_subnetworks = false
}
```

# Subnet with secondary ranges for GKE
```bash
resource "google_compute_subnetwork" "subnet" {
  ip_cidr_range = "10.0.0.0/16"  # Primary range
  
  secondary_ip_range {
    range_name    = "pods"        # 10.1.0.0/16
    ip_cidr_range = "10.1.0.0/16"
  }
  
  secondary_ip_range {
    range_name    = "services"    # 10.2.0.0/16
    ip_cidr_range = "10.2.0.0/16"
  }
}

# GKE Autopilot cluster
resource "google_container_cluster" "primary_cluster" {
  name             = "boutique-cluster"
  enable_autopilot = true
  
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }
}
```
  

## Troubleshooting

### Common Issues
1. **Authentication Error**: Run `gcloud auth application-default login`
2. **Project Not Found**: Verify `project_id` in terraform.tfvars
3. **Quota Exceeded**: Check GCP quotas in Console → IAM & Admin → Quotas
4. **Network Conflicts**: Ensure CIDR ranges don't overlap with existing VPCs

### Useful Commands
```bash
# Check cluster status
kubectl cluster-info

# View all pods
kubectl get pods --all-namespaces

# Debug pod issues
kubectl describe pod <pod-name>

# View Terraform state
terraform show
```

## Cleanup

**⚠️ Important**: Always clean up resources to avoid charges!

```bash
# Delete Kubernetes resources first
kubectl delete -f kubernetes-manifests/

# Destroy infrastructure
terraform destroy

# Confirm by typing 'yes' when prompted
```

## Cost Optimization

- **Free Tier**: This setup fits within GCP Free Tier limits
- **Resource Management**: Uses `e2-medium` instances (cost-effective)
- **Auto-scaling**: Configured for efficient resource utilization
- **Monitoring**: Enable billing alerts in GCP Console


## Support & Documentation

- [Google Kubernetes Engine Documentation](https://cloud.google.com/kubernetes-engine/docs)
- [Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Online Boutique Original Repository](https://github.com/GoogleCloudPlatform/microservices-demo)

---
