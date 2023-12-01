#!/bin/bash
sudo apt-get update

# install azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

#install kubectl
curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl 
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

#install kubelogin
sudo az aks install-cli

# install terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform

#install terragrunt
wget -O /tmp/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v0.40.0/terragrunt_linux_amd64
chmod +x /tmp/terragrunt
sudo mv /tmp/terragrunt /usr/local/bin/terragrunt
sudo chown -R $USER:$USER /home/saijiro/.azure

export KUBE_CONFIG_PATH=/home/seddine/.kube/config