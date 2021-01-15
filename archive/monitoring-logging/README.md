Installation:

helm3 install prometheus-operator prometheus-community/kube-prometheus-stack -n monitoring -f prom-operator.yaml
helm3 upgrade --install loki loki/loki-stack  -n monitoring -f loki-stack-value.yaml

Admin Credentials:
Username: admin
Password: prom-operator

