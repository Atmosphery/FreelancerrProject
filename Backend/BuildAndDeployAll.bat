rem FIRST SPRINGBOOT
@echo Creating java spring projects
cd ./UserService/userservice
call mvn clean package
cd ../../
rem SECOND DOTNET PROJECTS
@echo DOTNET builds
dotnet build -c Release
dotnet publish -c Release
rem CREATE DOCKER IMAGES
@echo building docker images
docker-compose build --no-cache 
rem CREATE DOCKER SWARM NETWORK
rem Docker swarm is to add redundancy functionality
rem READ MORE https://docs.docker.com/engine/swarm/
rem FIRST create the network
@echo creating docker swarm network
docker network create --driver overlay netSEN3
rem START DOCKER SWARM
@echo Creating docker swarm
docker swarm init
rem LAST USE THE DOCKERCOMPOSE FILE TO DEPLOY THE SERVICES
@echo Deploying docker swarm!
docker stack deploy -c docker-compose.yml packagedAPIs

@echo finished deploying docker swarm
@echo Wait at least 60 seconds for eureka and apigateway to register services