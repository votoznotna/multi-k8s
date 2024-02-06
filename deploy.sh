docker build -t antonzotov/multi-client:latest -t antonzotov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t antonzotov/multi-server:latest -t antonzotov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t antonzotov/multi-worker:latest -t antonzotov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push antonzotov/multi-client:latest
docker push antonzotov/multi-server:latest
docker push antonzotov/multi-worker:latest

docker push antonzotov/multi-client:$SHA
docker push antonzotov/multi-server:$SHA
docker push antonzotov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=antonzotov/multi-server:$SHA
kubectl set image deployments/client-deployment client=antonzotov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=antonzotov/multi-worker:$SHA
