docker build -t calvintjf/multi-client:latest -t calvintjf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t calvintjf/multi-server:latest -t calvintjf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t calvintjf/multi-worker:latest -t calvintjf/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push calvintjf/multi-client:latest
docker push calvintjf/multi-server:latest
docker push calvintjf/multi-worker:latest
docker push calvintjf/multi-client:$SHA
docker push calvintjf/multi-server:$SHA
docker push calvintjf/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=calvintjf/multi-server:$SHA
kubectl set image deployments/client-deployment client=calvintjf/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=calvintjf/multi-worker:$SHA

