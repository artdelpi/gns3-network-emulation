# GNS3-NETWORK-EMULATION - CIC0201 (Segurança Computacional) - 2025/1

Este projeto tem como objetivo simular a implementação de um firewall em uma rede corporativa utilizando o GNS3. O cenário foi desenvolvido como parte do Trabalho de Implementação 3 da disciplina CIC0201 - Segurança Computacional (UnB).

---

## Estrutura da Rede

A topologia contempla cinco sub-redes:

- **Sub-rede 1 – Internet Pública** (`172.16.0.0/24`)
- **Sub-rede 2 – DMZ (Servidor DHCP)** (`10.0.30.0/24`)
- **Sub-rede 3 – Link Interno (entre roteadores)** (`192.168.0.0/24`)
- **Sub-rede 4 – Estações Internas** (`172.16.0.0/24`)
- **Sub-rede 5 – Rede Interna com DHCP** (`10.0.40.0/24`)

![Topologia da rede](captures/img1.png)

### Dispositivos e funções:

- **Router1 (Firewall):** roteamento entre sub-redes, aplicação de regras `iptables`.
- **Router2 (DHCP Relay):** retransmite requisições da Sub-rede 5 para o Servidor DHCP.
- **DHCPServer (Debian via VMWare):** atribui IPs à Sub-rede 5 (faixa `10.0.40.100` a `10.0.40.200`).
- **WebServer (Debian via VMWare):** responde a requisições HTTP da Sub-rede 4.
- **Webterm-public / Webterm-workstation:** clientes de teste, realizam `curl`, `ping`, e requisitam IP via DHCP.

---

## Execução e Configuração

### Pré-requisitos

- **GNS3** (v2.2.5+)
- **VMware Workstation** com imagens Debian 11.10
- **Python 3** (já disponível nos hosts)
- **Ferramentas de rede** (`dhcpd`, `dhclient`, `iptables`, `curl`, `tcpdump`, `wireshark`)

### Scripts

Estão disponíveis na pasta [`scripts/`](scripts/):

- `config-firewall-router1.sh` → aplica regras `iptables`.
- `config-dhcpserver.sh` → atribui IPs, ativa encaminhamento e servidor DHCP.
- `rc.local-*` → inicializam automaticamente servidores HTTP em background.

> Para execução automática no boot, os scripts foram adicionados em `/etc/rc.local` nas VMs Debian.

---

## Testes realizados

### 1. Sub-rede 4 acessa WebServer

O host `webterm-public` acessa via `curl http://10.0.20.100`. O Wireshark exibe a sequência TCP (`SYN`, `ACK`, `GET`, `200 OK`).

### 2. Sub-redes 4 e 5 acessam Servidor DHCP

O WebServer exibe uma página estática. O acesso é validado com `curl http://10.0.30.1` a partir de ambas as sub-redes.

### 3. Sub-rede 4 acessa Router1 via HTTP

Foi disponibilizado um servidor HTTP simples em `172.16.0.254`. A resposta HTML e o handshake TCP foram registrados.

### 4. DHCP com Relay funcionando

Capturas mostram pacotes `DHCPDISCOVER`, `DHCPREQUEST`, `DHCPACK`. O host `webterm-workstation` obteve IP `10.0.40.100`.

---

## Estrutura do Repositório

GNS3-NETWORK-EMULATION
├── captures/ # Prints e capturas usadas no relatório
├── docs/ # Proposta e relatório final em PDF
│
├── scripts/
│ ├── config/ # Scripts de configuração de cada host/roteador
│ │ ├── config-*.sh
│ │ ├── dhcpd.conf # Configuração do servidor DHCP
│ │ └── isc-dhcp-relay # Configuração do DHCP Relay (Router2)
│ │
│ └── rc-local/ # Scripts rc.local para boot automatizado de cada nó
│ ├── rc.local-router1
│ ├── rc.local-router2
│ ├── rc.local-dhcpserver
│ ├── rc.local-webserver
│ └── rc.local-webtermpublic
│
├── .gitignore
├── gns3_topology.gns3
└── README.md
projeto-firewall/

---

## Funcionalidades Testadas

- Atribuição dinâmica de IP via DHCP relay
- Restrições e permissões de acesso via firewall no Router1 (`iptables`)
- Acesso HTTP entre diferentes sub-redes conforme regras definidas
- Servidores HTTP rodando automaticamente no boot com `rc.local`
- Validação por Wireshark e `curl`

## Relatórios

- [`docs/CIC0201-2025-1-Trab3-Proposta.pdf`](docs/CIC0201-2025-1-Trab3-Proposta.pdf)
- [`docs/CIC0201-2025-1-Trab3-Relatório.pdf`](docs/CIC0201-2025-1-Trab3-Relatório.pdf)

## Autor

Arthur Barbabella – Ciência da Computação, UnB (CIC0201 – Segurança Computacional)


