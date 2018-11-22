echo "entered in bash script"

docker build -t vijayakrishnajava/multi-client:latest -t vijayakrishnajava/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t vijayakrishnajava/multi-server:latest -t vijayakrishnajava/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t vijayakrishnajava/multi-worker:latest -t vijayakrishnajava/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push vijayakrishnajava/multi-client:latest
docker push vijayakrishnajava/multi-server:latest
docker push vijayakrishnajava/multi-worker:latest

docker push vijayakrishnajava/multi-client:$SHA
docker push vijayakrishnajava/multi-server:$SHA
docker push vijayakrishnajava/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=vijayakrishnajava/multi-client:$SHA
kubectl set image deployments/server-deployment server=vijayakrishnajava/multi-server:$SHA
kubectl set image deployments/worker-deployment server=vijayakrishnajava/multi-worker:$SHA
