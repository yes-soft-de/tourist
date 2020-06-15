# Build the Secret
docker build ./dev_symfony -f ./dev_symfony/config.Dockerfile -t gcr.io/project/config:latest

# Build the server container, it holds the project files
docker build ./dev_symfony -f ./dev_symfony/server.Dockerfile -t gcr.io/project/server-container:latest
docker push gcr.io/project/server-container

# Build the 
docker build ./nginx -t gcr.io/project/tourists-server:latest
docker push gcr.io/project/tourists-server