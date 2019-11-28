#!/bin/bash

docker run hello-world

# Installing Docker compose
sudo apt-get install -y docker-compose

# Installing Nodejs and npm
curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
sudo apt-get install -y nodejs

# Installing go language (get the last version on their website)
sudo apt-get install -y golang
go version

echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=${PATH}:${GOPATH}/bin' >> ~/.bashrc
source ~/.bashrc
#go get github.com/golang/example/hello
#hello

# Installing Sawtooth
[ -d Sawtooth ] || mkdir Sawtooth
cd Sawtooth

wget -O sawtooth-default.yaml https://raw.githubusercontent.com/hyperledger/education/master/LFS171x/sawtooth-material/sawtooth-default.yaml
docker-compose -f sawtooth-default.yaml up

# Open an another terminal
#docker exec -it sawtooth-shell-default bash
#curl http://rest-api:8008/blocks
docker exec -it sawtooth-shell-default curl http://rest-api:8008/blocks
# should see a json file starting with data
# open a new terminal
#curl http://localhost:8008/blocks
docker exec -it sawtooth-shell-default curl http://localhost:8008/blocks

docker-compose -f sawtooth-default.yaml down
cd ..

#Installing Hyperledger Fabric Docker images and binaries
[ -d Fabric ] || mkdir Fabric
cd Fabric

curl -sSL http://bit.ly/2ysbOFE | bash -s 1.2.1
export PATH=$(pwd)/Fabric/bin:$PATH
# confirming and visualizing the list of Docker images you’ve just downloaded
#docker images
# If the Docker images are not already tagged with the latest tag, perform the following command for each of the Docker images
#docker tag hyperledger/fabric-tools:x86_64-1.0.2 hyperledger/fabric-tools:latest (change the tag and the image of needed)

# Installing Hyperledger Fabric
git clone https://github.com/hyperledger/fabric-samples.git
cd fabric-samples/first-network
# Start your first network
./byfn.sh -m generate
# Any difficulties
#docker rmi -f $(docker images -q)
#TO QUIT : ctrl+C + ./byfn.sh -m down
