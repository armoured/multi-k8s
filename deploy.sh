docker build -t armoured/multi-client:latest -t armoured/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t armoured/multi-server:latest -t armoured/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t armoured/multi-worker:latest -t armoured/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push armoured/multi-client:latest
docker push armoured/multi-server:latest
docker push armoured/multi-worker:latest

docker push armoured/multi-client:$SHA
docker push armoured/multi-server:$SHA
docker push armoured/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=armoured/multi-server:$SHA
kubectl set image deployments/client-deployment client=armoured/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=armoured/multi-worker:$SHA