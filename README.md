# Secure RKE2 Kubernetes Platform on AWS

This project provisions AWS infrastructure with Terraform and deploys a secure RKE2 Kubernetes cluster on Ubuntu EC2.

## Current Architecture

```text
GitHub Repo
    ↓
Terraform
    ↓
AWS VPC
    ↓
Public Subnet + Internet Gateway + Route Table
    ↓
Security Group
    ↓
Ubuntu EC2 Instance
    ↓
Elastic IP
    ↓
RKE2 Kubernetes Cluster
    ↓
NGINX Deployment + NodePort Service

## Phase 2 Progress

### Kubernetes Platform
- Installed Helm
- Installed Argo CD via Helm
- Created the `argocd` namespace
- Verified all Argo CD components are healthy
- Retrieved the initial admin password
- Prepared the cluster for GitOps deployments

### Current Architecture

GitHub
↓
Terraform
↓
AWS
↓
Ubuntu
↓
RKE2
↓
Kubernetes
↓
Helm
↓
Argo CD