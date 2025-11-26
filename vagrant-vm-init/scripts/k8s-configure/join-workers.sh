kubeadm token create --print-join-command

# Worker 1
vagrant ssh k8s-worker-1 -c "sudo kubeadm join 192.168.56.10:6443 --token 9sceec.sk1el8m7334k1yiq --discovery-token-ca-cert-hash sha256:d3065cfdeecae4b1c37aeb868ca806b5b681e1ee9ebbeb1e711dfc8a52de27ec"

# Worker 2
vagrant ssh k8s-worker-2 -c "sudo kubeadm join 192.168.56.10:6443 --token 9sceec.sk1el8m7334k1yiq --discovery-token-ca-cert-hash sha256:d3065cfdeecae4b1c37aeb868ca806b5b681e1ee9ebbeb1e711dfc8a52de27ec"

# Worker 3
vagrant ssh k8s-worker-3 -c "sudo kubeadm join 192.168.56.10:6443 --token 9sceec.sk1el8m7334k1yiq --discovery-token-ca-cert-hash sha256:d3065cfdeecae4b1c37aeb868ca806b5b681e1ee9ebbeb1e711dfc8a52de27ec"
