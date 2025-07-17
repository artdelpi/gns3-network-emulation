#!/bin/bash

# Configura IP da interface conectada à Sub-rede 2 (Servidores Internos)
ip addr add 10.0.30.1/24 dev ens4
ip link set ens4 up

# Define o gateway como o Router1
ip route add default via 10.0.30.254
