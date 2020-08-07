docker build -t shivanggoswami/multi-client:latest -t shivanggoswami/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t shivanggoswami/multi-server:latest -t shivanggoswami/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t shivanggoswami/multi-worker:latest -t shivanggoswami/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push shivanggoswami/multi-client:latest
docker push shivanggoswami/multi-server:latest
docker push shivanggoswami/multi-worker:latest

docker push shivanggoswami/multi-client:$GIT_SHA
docker push shivanggoswami/multi-server:$GIT_SHA
docker push shivanggoswami/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shivanggoswami/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=shivanggoswami/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=shivanggoswami/multi-worker:$GIT_SHA
