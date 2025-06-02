# Online Boutique DevOps Implementation

Terraform-based Google Cloud infrastructure for deploying the Online Boutique microservices demo application, following DevOps best practices.

## Solution Overview
- **Infrastructure as Code**: Terraform-managed GCP resources
- **Cluster Networking**: Precisely configured CIDR ranges for nodes, pods, and services
- **Security**: IAM roles with least privilege principle
- **Collaboration**: Remote state management and variable separation
- **CI/CD Simulation**: Deployment script for Kubernetes manifests

## Repository Structure
```tree
.
├── README.md                   # This documentation
├── deploy.sh                   # Application deployment script (CI/CD simulation)
├── kubernetes-manifests/       # Microservices application
│   └── microservices-demo.yaml
├── modules/                    # Reusable Terraform modules
│   ├── network/
│   ├── gke/
│   └── iam/
├── main.tf                     # Primary infrastructure configuration
├── outputs.tf                  # Terraform output definitions
├── variables.tf                # Variable declarations
├── terraform.tfvars.example    # Example variables file
└── versions.tf                 # Provider/version constraints

Precision Networking

Nodes: 10.0.0.0/16

Pods: 10.1.0.0/16

Services: 10.2.0.0/16

Security Controls

Dedicated service accounts with minimal permissions

IAM role separation for developers vs deployers

GKE workload identity integration

Deployment Workflow
Initialize Infrastructure

bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan
Deploy Application

bash
chmod +x deploy.sh
./deploy.sh
Access Application

bash
kubectl get service frontend-external | awk '{print $4}'

Customization
Copy example variables file:

bash
cp terraform.tfvars.example terraform.tfvars
Edit terraform.tfvars with your configuration:

hcl
project_id       = "your-project-id"
region           = "europe-west1"
cluster_name     = "online-boutique-prod"

Cleanup
bash
terraform destroy