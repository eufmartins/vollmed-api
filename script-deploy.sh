#!/bin/bash
set -e  # para parar se houver erro real

# Ir para a pasta onde estão os arquivos
cd /home/ubuntu

# Parar containers existentes (se houver)
container_ids=$(docker ps -q)
if [ -z "$container_ids" ]; then
  echo "Não há container(s) em execução"
else
  for container_id in $container_ids; do
    echo "Parando container: $container_id"
    docker stop "$container_id"
  done
  echo "Todos os container(s) foram parados."
fi

mv docker-compose-prod.yaml docker-compose.yml

docker load -i vollmed-api.tar

docker compose up -d
