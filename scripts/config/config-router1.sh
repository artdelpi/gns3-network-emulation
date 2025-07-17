#!/bin/bash

# Sub-rede 1 (Internet pública)
ip addr add 10.0.20.254/24 dev ens5
ip link set ens5 up

# Sub-rede 2 (Servidores internos)
ip addr add 10.0.30.254/24 dev ens6
ip link set ens6 up

# Sub-rede 3 (Estação de trabalho interna)
ip addr add 172.16.0.254/24 dev ens4
ip link set ens4 up

# Sub-rede 4 (DMZ - WebServer)
ip addr add 10.0.24.254/24 dev ens3
ip link set ens3 up

# Sub-rede 5 (Link com Router2)
ip addr add 192.168.0.1/30 dev ens7
ip link set ens7 up

# Habilita o roteamento
echo 1 > /proc/sys/net/ipv4/ip_forward
