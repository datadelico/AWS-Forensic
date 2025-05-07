#!/bin/bash
sudo apt update
sudo apt install --yes ubuntu-dbgsym-keyring
sudo tee /etc/apt/sources.list.d/debug.list << EOF
deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main restricted universe multiverse
EOF
# Actualizar el sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependencias necesarias
sudo apt install -y python3 python3-pip git 

# Instalar Volatility3
pip install volatility3
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc

