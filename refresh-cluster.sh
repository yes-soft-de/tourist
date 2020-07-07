docker build ./dev_symfony -f ./dev_symfony/server.Dockerfile -t gcr.io/tourists-280412/server-container:latest
docker push gcr.io/tourists-280412/server-container:latest

docker build ./nginx -t gcr.io/tourists-280412/tourists-server:latest
docker push gcr.io/tourists-280412/server-container:latest
