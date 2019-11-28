#!/bin/bash

# Installing cURL
sudo apt-get update
sudo apt-get install -y curl

# Installing Docker CE
# 1 - Check Ubuntu version

# 2 - Uninstall old docker versions
sudo apt-get remove docker docker-engine docker.io

# 3 - Setup the repository
# Installing packages to allow apt to use a repository over HTTPS
sudo apt-get install -y apt-transport-https ca-certificates software-properties-common

# Adding Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint
sudo apt-key fingerprint 0EBFCD88

# Set up the stable repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# 4 - Installing Docker CE (repository method)
# Updating the apt package index
sudo apt-get update

# Installing the latest version of Docker CE
sudo apt-get install -y docker-ce

# Manage Docker as a Non-Root User
sudo usermod -aG docker $USER
