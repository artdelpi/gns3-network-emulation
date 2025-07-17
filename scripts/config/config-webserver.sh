#!/bin/bash

# Configura IP da interface conectada à DMZ
ip addr add 10.0.20.100/24 dev ens4
ip link set ens4 up

# Define o gateway como o Router1
ip route add default via 10.0.20.254
