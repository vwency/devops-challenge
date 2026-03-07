kubectl apply -k github.com/zalando/postgres-operator/manifests


kubectl apply -f https://raw.githubusercontent.com/zalando/postgres-operator/v1.15.1/manifests/configmap.yaml
kubectl apply -f https://raw.githubusercontent.com/zalando/postgres-operator/v1.15.1/manifests/operator-service-account-rbac.yaml
kubectl apply -f https://raw.githubusercontent.com/zalando/postgres-operator/v1.15.1/manifests/postgres-operator.yaml
