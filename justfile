set dotenv-load

list:
  just --list

run:
  docker compose up -d --force-recreate

update:
  docker compose pull
  docker compose up -d --force-recreate --build
