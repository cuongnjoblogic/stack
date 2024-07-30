# Set the ECR_URI variable
$ECR_URI = "891377111816.dkr.ecr.us-east-1.amazonaws.com/voting-app"  # Replace with the actual ECR URI

# Read the content of the docker-compose.yml file
$dockerComposeFilePath = "docker-compose.yml"
$dockerComposeContent = Get-Content -Path $dockerComposeFilePath

# Perform the replacements
$dockerComposeContent = $dockerComposeContent -replace "dockersamples/examplevotingapp_worker", "${ECR_URI}:worker"
$dockerComposeContent = $dockerComposeContent -replace "dockersamples/examplevotingapp_result:before", "${ECR_URI}:result"
$dockerComposeContent = $dockerComposeContent -replace "dockersamples/examplevotingapp_vote:before", "${ECR_URI}:vote"

# Write the modified content back to the file
$dockerComposeContent | Set-Content -Path $dockerComposeFilePath

Write-Host "Updated docker-compose.yml with ECR URIs."

Write-Host "Deploying the stack..."
docker stack deploy --with-registry-auth --compose-file docker-compose.yml voting-app

Write-Host "Deployment complete."