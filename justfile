set dotenv-load

list:
  just --list

run:
  docker compose up -d --force-recreate

update:
  docker compose pull
  docker compose up -d --force-recreate --build

update-version:
  #!/usr/bin/env bash
  CURRENT=$(dotenvx get GLANCE_VERSION)
  LATEST=$(curl -s https://api.github.com/repos/glanceapp/glance/releases/latest | jq -r '.tag_name')
  echo "Current GLANCE_VERSION: $CURRENT"
  if [ "$CURRENT" != "$LATEST" ]; then
    echo "Updating GLANCE_VERSION to $LATEST"
    dotenvx set GLANCE_VERSION "$LATEST"
    echo "Updated! Run 'just update' to apply the new version."
  else
    echo "Already up to date!"
  fi
