BASE IMAGE DOCKER BUILD - RUN IN ~/baseImage directory
docker build -t iis-base-image:prod . --build-arg CERTPASS=<password>


MAIN DOCKER BUILD - RUN IN solution directory
docker build -t iis-dotnetframework:build .
docker run -p 8081:80 -v "C:\images\:C:\images\"  -t iis-dotnetframework:build















