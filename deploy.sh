 docker build -t huntercongress/multi-client:latest -t huntercongress/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t huntercongress/multi-server:latest -t huntercongress/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t huntercongress/mutli-worker:latest -t huntercongress/mutli-worker:$SHA -f ./worker/Dockerfile ./worker

docker push huntercongress/multi-client:latest
docker push huntercongress/multi-server:latest
docker push huntercongress/mutli-worker:latest

docker push huntercongress/multi-client:$SHA
docker push huntercongress/multi-server:$SHA
docker push huntercongress/mutli-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=huntercongress/multi-server:$SHA
kubectl set image deployments/client-deployment client=huntercongress/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=huntercongress/mutli-worker:$SHA