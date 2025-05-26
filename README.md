# Kubernetes CI/CD Deployment with Jenkins and Docker

This project demonstrates a full CI/CD pipeline for a Java-based web app application using Jenkins, Docker, and a Kubernetes production cluster.

## Project Overview
- **Project 1**: EC2-based deployment using Tomcat and manual steps
- **Project 2**: Kubernetes production cluster setup using Terraform, Kops, and Ansible
- **Project 3**: CI/CD integration with Jenkins, Docker Hub, and Kubernetes

## Tools & Technologies
- AWS EC2, S3
- Kops for cluster creation
- Jenkins for CI/CD
- Docker for image build/push
- Kubernetes for deployment
- Kubectl for cluster interaction

## Pipeline Stages
1. **Checkout Code**: Pulls code from GitHub project-3 branch
2. **Build Docker Image**: Uses Dockerfile to create a new image
3. **Push to Docker Hub**: Uploads image to Docker Hub under `samsow/webcalculator`
4. **Deploy to Kubernetes**: Applies deployment and service YAMLs
5. **Verify Deployment**: Confirms pods and services status

## Folder Structure
/k8s
├── deployment.yaml
└── service.yaml
/Jenkinsfile
/Dockerfile
/README.md
## Deployment Verification
Access the application using the DNS of the LoadBalancer exposed by the Kubernetes service.
