#!/bin/bash

# Políticas padrão
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

# Permitir loopback local
iptables -A INPUT -i lo -j ACCEPT

# Permitir ping ao próprio roteador (debug)
iptables -A INPUT -p icmp -j ACCEPT

# Permitir conexões estabelecidas e relacionadas
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Permitir conexões HTTP da Sub-rede 4 (172.16.0.0/24) para o WebServer (10.0.20.100)
iptables -A FORWARD -p tcp -s 172.16.0.0/24 -d 10.0.20.100 --dport 80 -j ACCEPT

# Permitir conexões HTTP da Sub-rede 5 (10.0.40.0/24) para o WebServer (10.0.20.100)
iptables -A FORWARD -p tcp -s 10.0.40.0/24 -d 10.0.20.100 --dport 80 -j ACCEPT

# Permitir conexões HTTP da Sub-rede 4 para o DHCPServer (10.0.30.1)
iptables -A FORWARD -p tcp -s 172.16.0.0/24 -d 10.0.30.1 --dport 80 -j ACCEPT

# Permitir conexões HTTP da Sub-rede 5 para o DHCPServer
iptables -A FORWARD -p tcp -s 10.0.40.0/24 -d 10.0.30.1 --dport 80 -j ACCEPT

# Permitir HTTP da Sub-rede 4 para o Router1 (interface 172.16.0.254)
iptables -A INPUT -p tcp -s 172.16.0.0/24 -d 172.16.0.254 --dport 80 -j ACCEPT

# Permitir tráfego DHCP: Solicitações da Sub-rede 3 para o DHCPServer
iptables -A FORWARD -p udp -s 10.0.40.0/24 -d 10.0.30.1 --sport 68 --dport 67 -j ACCEPT

# Permitir respostas DHCP do Servidor (10.0.30.1) para os hosts da Sub-rede 5
iptables -A FORWARD -p udp -s 10.0.30.1 -d 10.0.40.0/24 --sport 67 --dport 68 -j ACCEPT
