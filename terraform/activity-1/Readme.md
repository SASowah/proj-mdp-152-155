# 📘 Project 1: EC2-Based CI/CD with Terraform, Maven & Tomcat

## 📌 Overview
This project provisions a complete CI/CD pipeline using AWS EC2 instances, configured via Terraform, to build and deploy a Java web application using Maven and Apache Tomcat.

## 🧱 Tech Stack
- **Terraform** – Infrastructure as Code
- **AWS EC2** – Build and runtime servers
- **Apache Tomcat 7** – Application server
- **Maven** – Build automation for Java `.war` files
- **Amazon Linux 2** – EC2 base OS

## ⚙️ Architecture

- **Custom VPC** with:
  - Internet Gateway
  - Public Subnets (2 AZs)
  - Route Tables and Associations

- **Two EC2 Instances**:
  - **Build Server** (Maven, Java, Git)
  - **Tomcat Server** (Java,Tomcat)

## 🚀 Provisioning Workflow

1. Infrastructure is provisioned using Terraform:
   - VPC, subnets, route tables, security groups, EC2s
2. **User data** scripts bootstrap each EC2:
   - **Build Server** clones repo and builds `.war`
   - **Tomcat Server** installs and starts Tomcat

## 🔧 Manual Steps Performed
- `.pem` file was securely SCP’d to the Build Server
- The `.war` file was manually SCP’d from the Build Server to the Tomcat Server
- The `.war` was moved into `/opt/tomcat/webapps/` with `sudo`
- Tomcat was restarted to deploy the app


## 🧠 Next Phase
In **Phase 2**, we’ll Dockerize the application and introduce Jenkins to automate the build and deploy pipeline end-to-end.