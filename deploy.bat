
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 020698190649.dkr.ecr.us-east-1.amazonaws.com
docker build -t iis-dotnetframework --build-arg source=. .\LegacyApplication
docker tag iis-dotnetframework:latest 020698190649.dkr.ecr.us-east-1.amazonaws.com/iis-dotnetframework:latest
docker push 020698190649.dkr.ecr.us-east-1.amazonaws.com/iis-dotnetframework:latest

