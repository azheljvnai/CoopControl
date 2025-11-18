# Kubernetes Deployment Guide for CoopControl

This directory contains Kubernetes manifests for deploying CoopControl in a Kubernetes cluster.

## Prerequisites

- A running Kubernetes cluster (minikube, GKE, EKS, AKS, or any other)
- `kubectl` configured to access your cluster
- Docker image of the application pushed to a container registry

## Building and Pushing the Docker Image

Before deploying to Kubernetes, you need to build and push the Docker image:

```bash
# Build the Docker image
docker build -t your-registry/coopcontrol:latest .

# Push to your registry
docker push your-registry/coopcontrol:latest
```

Update `kubernetes/app-deployment.yaml` with your image location:
```yaml
image: your-registry/coopcontrol:latest
```

## Deployment Steps

### 1. Create Namespace

```bash
kubectl apply -f kubernetes/namespace.yaml
```

### 2. Create ConfigMaps and Secrets

⚠️ **Important**: Edit `kubernetes/configmap.yaml` and change the MySQL root password before deploying!

```bash
kubectl apply -f kubernetes/configmap.yaml
```

### 3. Create Persistent Volume Claim

```bash
kubectl apply -f kubernetes/mysql-pvc.yaml
```

Check storage class availability:
```bash
kubectl get storageclass
```

Update `mysql-pvc.yaml` if needed to match your cluster's storage class.

### 4. Deploy MySQL

```bash
kubectl apply -f kubernetes/mysql-deployment.yaml
```

Wait for MySQL to be ready:
```bash
kubectl wait --for=condition=ready pod -l app=mysql -n coopcontrol --timeout=300s
```

### 5. Deploy the Application

```bash
kubectl apply -f kubernetes/app-deployment.yaml
```

## Verification

### Check Pod Status

```bash
kubectl get pods -n coopcontrol
```

### View Logs

Application logs:
```bash
kubectl logs -f -l app=coopcontrol -n coopcontrol
```

MySQL logs:
```bash
kubectl logs -f -l app=mysql -n coopcontrol
```

### Access the Application

Get the service details:
```bash
kubectl get svc -n coopcontrol
```

For LoadBalancer:
```bash
kubectl get svc coopcontrol-service -n coopcontrol
```

For NodePort (if you changed the service type):
```bash
minikube service coopcontrol-service -n coopcontrol  # For minikube
# OR
kubectl port-forward svc/coopcontrol-service 8080:80 -n coopcontrol
```

## Scaling

Scale the application:
```bash
kubectl scale deployment coopcontrol-app --replicas=3 -n coopcontrol
```

## Updates

Update the application image:
```bash
kubectl set image deployment/coopcontrol-app coopcontrol=your-registry/coopcontrol:v2 -n coopcontrol
```

Check rollout status:
```bash
kubectl rollout status deployment/coopcontrol-app -n coopcontrol
```

Rollback if needed:
```bash
kubectl rollout undo deployment/coopcontrol-app -n coopcontrol
```

## Cleanup

Remove all resources:
```bash
kubectl delete -f kubernetes/app-deployment.yaml
kubectl delete -f kubernetes/mysql-deployment.yaml
kubectl delete -f kubernetes/mysql-pvc.yaml
kubectl delete -f kubernetes/configmap.yaml
kubectl delete -f kubernetes/namespace.yaml
```

## Production Considerations

1. **Use External Database**: Consider using a managed database service instead of running MySQL in Kubernetes
2. **Ingress**: Set up an Ingress controller for better traffic management
3. **TLS/SSL**: Configure TLS certificates for secure communication
4. **Secrets Management**: Use external secrets management (e.g., HashiCorp Vault, AWS Secrets Manager)
5. **Monitoring**: Set up Prometheus and Grafana for monitoring
6. **Logging**: Configure centralized logging (e.g., ELK stack)
7. **Resource Limits**: Adjust resource requests and limits based on your workload

## Troubleshooting

### Pods not starting

Check events:
```bash
kubectl describe pod <pod-name> -n coopcontrol
```

### Database connection issues

Verify MySQL is running:
```bash
kubectl get pods -l app=mysql -n coopcontrol
```

Check MySQL logs:
```bash
kubectl logs -l app=mysql -n coopcontrol
```

Test database connectivity from app pod:
```bash
kubectl exec -it <app-pod-name> -n coopcontrol -- sh
# Inside the pod:
nc -zv mysql-service 3306
```

### Image pull errors

Ensure your image is accessible:
```bash
kubectl describe pod <pod-name> -n coopcontrol
```

You may need to create an image pull secret for private registries.
