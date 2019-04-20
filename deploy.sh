docker build -t loki194/multi-client:latest -t loki194/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t loki194/multi-server:latest -t loki194/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t loki194/multi-worker:latest -t loki194/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push loki194/multi-client:latest
docker push loki194/multi-server:latest
docker push loki194/multi-worker:latest

docker push loki194/multi-client:$SHA
docker push loki194/multi-server:$SHA
docker push loki194/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=loki194/multi-server:$SHA
kubectl set image deployments/client-deployment client=loki194/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=loki194/multi-worker:$SHA