#!/bin/bash

# Configurar IP da interface na Sub-rede 1 (Internet Pública)
ip addr add 10.0.20.10/24 dev ens4
ip link set ens4 up

# Adicionar rota default apontando para o Router1
ip route add default via 10.0.20.254
