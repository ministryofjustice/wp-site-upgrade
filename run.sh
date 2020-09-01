#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0m' # No Color

for d in ~/sites/*; do
  if [[ -f "$d/docker-compose.yml" ]]; then
    while true; do
      read -r -p "$(echo -e "${GREEN}Do you wish to update $(basename "$d")?${NC}") " yn
      case $yn in
      [Yy]*)
        cd "$d" || exit
        site-upgrade .
        cd ..
        break
        ;;
      [Nn]*) break ;;
      *) echo "Please answer yes or no." ;;
      esac
    done
  fi
done
