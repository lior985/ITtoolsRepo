#!/bin/bash

HOSTS=(
  192.168.56.11  
  192.168.56.12 
  192.168.56.13
  192.168.56.14
)

SSH_USER="automation"
SSH_PASS="devops"

if ! command -v sshpass >/dev/null; then
  echo "[+] Installing sshpass..."
  sudo dnf install -y sshpass || { echo "[-] Failed to install sshpass"; exit 1; }
fi


# Generate SSH key if it doesn't exist
if [ ! -f ~/.ssh/id_rsa ]; then
  echo "[+] Generating SSH key..."
  ssh-keygen -t rsa -b 2048 -N "" -f ~/.ssh/id_rsa
fi

for HOST in "${HOSTS[@]}"; do
  echo "[+] Copying key to $HOST..."
  sshpass -p "$SSH_PASS" ssh-copy-id -o StrictHostKeyChecking=no "$SSH_USER@$HOST"
done

echo "operation completed"
