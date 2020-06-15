# Build the Secret
docker build ./dev_symfony -f ./dev_symfony/config.Dockerfile -t gcr.io/tourists-280412/config:latest

# Build the server container, it holds the project files
docker build ./dev_symfony -f ./dev_symfony/server.Dockerfile -t gcr.io/tourists-280412/server-container:latest
docker push gcr.io/tourists-280412/server-container

# Build the 
docker build ./nginx -t gcr.io/tourists-280412/tourists-server:latest
docker push gcr.io/tourists-280412/tourists-server