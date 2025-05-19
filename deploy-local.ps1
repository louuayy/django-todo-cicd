Write-Output "Starting Minikube..."
minikube start --driver=docker

Write-Output "Applying Kubernetes manifests..."
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

Write-Output "Waiting for deployment to be ready..."
kubectl rollout status deployment/django-app

Write-Output "Starting Minikube service tunnel in the background..."
Start-Job -ScriptBlock { minikube service django-service --url }

Write-Output "Waiting for service URL to be available..."
Start-Sleep -Seconds 5
$serviceUrl = (minikube service django-service --url | Select-Object -First 1)

Write-Output "Opening app in browser..."
if ($serviceUrl) {
    Start-Process $serviceUrl
    Write-Output "Deployment complete! App should be accessible at: $serviceUrl"
} else {
    Write-Output "Failed to get service URL. Please run 'minikube service django-service --url' manually."
}