docker build -t mbhuiyan13/multi-container-client:latest -t mbhuiyan13/multi-container-client:$SHA ./client/Dockerfile ./client
docker build -t mbhuiyan13/multi-container-server:latest -t mbhuiyan13/multi-container-server:$SHA ./server/Dockerfile ./server
docker build -t mbhuiyan13/multi-container-worker:latest -t mbhuiyan13/multi-container-worker:$SHA ./worker/Dockerfile ./worker

docker push mbhuiyan13/multi-container-client:latest
docker push mbhuiyan13/multi-container-server:latest
docker push mbhuiyan13/multi-container-worker:latest

docker push mbhuiyan13/multi-container-client:$SHA
docker push mbhuiyan13/multi-container-server:$SHA
docker push mbhuiyan13/multi-container-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mbhuiyan13/multi-container-server:$SHA
kubectl set image deployments/client-deployment client=mbhuiyan13/multi-container-client:$SHA
kubectl set image deployments/worker-deployment worker=mbhuiyan13/multi-container-worker:$SHA