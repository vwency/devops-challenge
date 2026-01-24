minikube start \
  --driver=kvm2 \
  --cpus=6 \
  --memory=15000 \
  --disk-size=35g \
  --network-plugin=cni \
  --cni=false \
  -p challenge
