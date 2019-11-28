#!/bin/bash

#Installing cURL
sudo apt install curl
curl -V

#Installing Docker CE
# 1 - Check Ubuntu version
lsb_release -a
# 2 - Uninstall old docker versions
sudo apt-get remove docker docker-engine docker.io
# 3 - Setup the repository
    #Updating the apt package index:
    sudo apt-get update
    #Installing packages to allow apt to use a repository over HTTPS
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common
    #Adding Docker’s official GPG key:    
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    #Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint
    sudo apt-key fingerprint 0EBFCD88
    #Set up the stable repository
    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
# 4 - Installing Docker CE (repository method)
    #Updating the apt package index
    sudo apt-get update
    #Installing the latest version of Docker CE 
    sudo apt-get install docker-ce
    #Verifying that Docker CE is installed correctly by running the hello-world image
    sudo docker run hello-world


#Manage Docker as a Non-Root User
sudo groupadd docker
sudo usermod -aG docker liz-user
#LOG OUT AND GO BACK IN AND RUN DOCKER WITHOUT SUDO
docker run hello-world

#Installing Docker compose
sudo apt update
sudo apt install docker-compose
#Check to make sure that you have Docker version 17.03.1-ce or greater, and Docker Compose version 1.14.0 or greater:
docker --version && docker-compose --version

#Installing Nodejs and npm
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt-get install -y nodejs
#Check versions
node --version && npm --version

#Installing go language (get the last version on their website)
sudo apt update
sudo apt install golang
go version
echo 'export GOPATH=$HOME/go' >> ~/.bashrc 
echo 'export PATH=${PATH}:${GOPATH}/bin' >> ~/.bashrc 
source ~/.bashrc 
go get github.com/golang/example/hello
hello 

#Installing Sawtooth
mkdir Sawtooth
cd Sawtooth
wget -O sawtooth-default.yaml https://raw.githubusercontent.com/hyperledger/education/master/LFS171x/sawtooth-material/sawtooth-default.yaml
cd sawtooth-default.yaml
docker-compose -f sawtooth-default.yaml up
#open an another terminal
docker exec -it sawtooth-shell-default bash 
#should see: root@75b380886502:/#
curl http://rest-api:8008/blocks
#should see a json file starting with data
#open a new terminal
curl http://localhost:8008/blocks
#ctrl+c
docker-compose -f sawtooth-default.yaml down

#Installing Hyperledger Fabric Docker images and binaries
mkdir Fabric
cd Fabric
curl -sSL http://bit.ly/2ysbOFE | bash -s 1.2.1
export PATH=$HOME/Fabric/bin:$PATH
    # confirming and visualizing the list of Docker images you’ve just downloaded
    docker images
    #If the Docker images are not already tagged with the latest tag, perform the following command for each of the Docker images
    #docker tag hyperledger/fabric-tools:x86_64-1.0.2 hyperledger/fabric-tools:latest (change the tag and the image of needed)

#Installing Hyperledger Fabric
git clone https://github.com/hyperledger/fabric-samples.git
cd fabric-samples/first-network
#Start your first network
./byfn.sh -m generate
#Any difficulties
#docker rmi -f $(docker images -q)
#TO QUIT : ctrl+C + ./byfn.sh -m down
