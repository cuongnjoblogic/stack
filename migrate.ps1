# Set AWS region
$AWS_REGION = "us-east-1"

# Create ECR repository and get the URI
$ECR_URI = "891377111816.dkr.ecr.us-east-1.amazonaws.com/voting-app"

# Login to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI

# Build and Push Images
$services = @("vote", "result", "worker")
foreach ($SERVICE in $services) {
  docker image build -t "${ECR_URI}:${SERVICE}" "${SERVICE}/"
  docker image push "${ECR_URI}:${SERVICE}"
}

#list all of images
aws ecr list-images --repository-name voting-app