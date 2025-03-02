#!/bin/bash

# Update packages
sudo dnf update -y

# Install required dependencies
sudo dnf install -y wget java-17-amazon-corretto

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
sudo dnf install -y jenkins

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Install Git
sudo dnf install -y git

# Install Terraform
sudo dnf install -y yum-utils
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo dnf install -y terraform

# Install kubectl
sudo curl -LO "https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl"
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
