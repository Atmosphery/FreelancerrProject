rem FIRST SPRINGBOOT
@echo Creating java spring projects
cd ./UserService/userservice
call mvn clean package
cd ../../

@echo "DOTNET builds"
dotnet build -c Release
dotnet publish -c Release

@echo "building docker images"
docker-compose build --no-cache 
@echo "Docker build complete"

@echo "creating docker swarm network"
docker network create --driver overlay netSEN3
@echo "Creating docker swarm"
docker swarm init
@echo "Docker swarm created"
@echo "Deploying docker swarm!"
docker stack deploy -c docker-compose.yml packagedAPIs

@echo "finished deploying docker swarm"
@echo Wait at least 60 seconds for eureka and apigateway to register services