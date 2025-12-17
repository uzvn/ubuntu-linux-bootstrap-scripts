#!/usr/bin/env bash
set -e

echo "=== Ubuntu Linux Bootstrap Starting ==="

sudo apt update && sudo apt upgrade -y

bash preflight.sh

bash apt.sh
bash snap.sh

bash post/cleanup.sh

echo "=== Bootstrap Completed Successfully ==="
