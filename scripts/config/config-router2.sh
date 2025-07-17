#!/bin/bash

# Sub-rede 3 (Estação interna) - ens4
ip addr add 10.0.40.253/24 dev ens4
ip link set ens4 up

# Sub-rede 5 (Link Interno com Router1) - ens5
ip addr add 192.168.0.2/30 dev ens5
ip link set ens5 up

# Rota para alcançar outras sub-redes via Router1
ip route add default via 192.168.0.1
