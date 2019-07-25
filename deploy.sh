docker build -t webworkers/multi-client:latest -t webworkers/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t webworkers/multi-server:latest -t webworkers/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t webworkers/multi-worker:latest -t webworkers/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push webworkers/multi-client:latest
docker push webworkers/multi-server:latest
docker push webworkers/multi-worker:latest

docker push webworkers/multi-client:$SHA
docker push webworkers/multi-server:$SHA
docker push webworkers/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=webworkers/multi-server:$SHA
kubectl set image deployments/client-deployment client=webworkers/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=webworkers/multi-worker:$SHA
