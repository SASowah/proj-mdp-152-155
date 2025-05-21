#!/bin/bash
sudo yum update -y
sudo yum install -y java-1.8.0-openjdk-devel

sudo wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.94/bin/apache-tomcat-7.0.94.tar.gz
tar -xvf apache-tomcat-7.0.94.tar.gz

ln -s apache-tomcat-7.0.94 tomcat
sudo mv apache-tomcat-7.0.94 /opt/tomcat
chmod +x /opt/tomcat/bin/*.sh
/opt/tomcat/bin/startup.sh