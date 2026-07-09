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