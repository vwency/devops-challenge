curl -sL https://istio.io/downloadIstioctl | sh -
export PATH=$HOME/.istioctl/bin:$PATH

istioctl install --set profile=default \
  --set components.cni.enabled=false \
  --set values.gateways.istio-ingressgateway.type=LoadBalancer \
  -y
