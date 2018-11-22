echo "entered in bash script"

docker build -t vijayakrishnajava/multi-client:latest -f ./client/Dockerfile ./client
docker build -t vijayakrishnajava/multi-server:latest -f ./server/Dockerfile ./server
docker build -t vijayakrishnajava/multi-worker:latest -f ./worker/Dockerfile ./worker

docker build -t vijayakrishnajava/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vijayakrishnajava/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vijayakrishnajava/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vijayakrishnajava/multi-client:latest
docker push vijayakrishnajava/multi-server:latest
docker push vijayakrishnajava/multi-worker:latest

docker push vijayakrishnajava/multi-client:$SHA
docker push vijayakrishnajava/multi-server:$SHA
docker push vijayakrishnajava/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment clientapp=vijayakrishnajava/multi-client:$SHA
kubectl set image deployments/server-deployment serverapp=vijayakrishnajava/multi-server:$SHA
kubectl set image deployments/worker-deployment workerapp=vijayakrishnajava/multi-worker:$SHA
