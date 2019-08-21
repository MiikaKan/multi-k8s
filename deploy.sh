docker build -t miikakan/multi-client:latest -t miikakan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t miikakan/multi-server:latest -t miikakan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t miikakan/multi-worker:latest -t miikakan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push miikakan/multi-client:latest
docker push miikakan/multi-server:latest
docker push miikakan/multi-worker:latest

docker push miikakan/multi-client:$SHA
docker push miikakan/multi-server:$SHA
docker push miikakan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=miikakan/multi-server:$SHA
kubectl set image deployments/client-deployment client=miikakan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=miikakan/multi-worker:$SHA