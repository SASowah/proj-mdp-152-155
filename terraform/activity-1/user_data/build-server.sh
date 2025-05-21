#!/bin/bash
exec > /var/log/userdata.log 2>&1
set -x

sudo yum update -y
sudo yum install -y java-11* git wget maven

cd /home/ec2-user
sudo -u ec2-user git clone https://github.com/SASowah/proj-mdp-152-155.git
cd /home/ec2-user/proj-mdp-152-155
sudo -u ec2-user mvn clean package