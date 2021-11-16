
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 020698190649.dkr.ecr.us-east-1.amazonaws.com
docker build -t iis-dotnetframework:latest-ec2 --build-arg source=. .\LegacyApplication
docker tag iis-dotnetframework:latest-ec2 020698190649.dkr.ecr.us-east-1.amazonaws.com/iis-dotnetframework:latest-ec2
docker push 020698190649.dkr.ecr.us-east-1.amazonaws.com/iis-dotnetframework:latest-ec2

