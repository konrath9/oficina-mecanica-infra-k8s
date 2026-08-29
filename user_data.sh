#!/bin/bash
set -euxo pipefail

# Instala k3s (server) - inclui Traefik (ingress) e ServiceLB, dispensando um Load Balancer gerenciado.
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
