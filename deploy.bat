
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 020698190649.dkr.ecr.us-east-1.amazonaws.com


docker build -t windows-fargate-legacy --build-arg source=. .\LegacyApplication
docker tag windows-fargate-legacy:latest 020698190649.dkr.ecr.us-east-1.amazonaws.com/windows-fargate-legacy:latest
docker push 020698190649.dkr.ecr.us-east-1.amazonaws.com/windows-fargate-legacy:latest

