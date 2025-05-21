#!/bin/bash
exec > >(tee /var/log/userdata.log | logger -t userdata) 2>&1
set -x

# Wait for yum lock to be released
while sudo fuser /var/run/yum.pid >/dev/null 2>&1; do
  echo "Waiting for yum lock..."
  sleep 5
done

yum update -y
yum install -y git wget java-17* docker

# Start and enable Docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# Install Jenkins
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key

# Wait again if yum is locked
while sudo fuser /var/run/yum.pid >/dev/null 2>&1; do
  echo "Waiting for yum lock again..."
  sleep 5
done

yum install -y jenkins
systemctl enable jenkins
systemctl start jenkins
