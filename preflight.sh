#!/usr/bin/env bash
set -e

echo "=== Preflight checks ==="

# Ensure sudo
sudo -v

# Bandwidth-aware mode
if [ "$LOW_BANDWIDTH" = "1" ]; then
  echo "LOW_BANDWIDTH mode enabled"
  APT_FLAGS="-y --no-install-recommends"
else
  APT_FLAGS="-y"
fi

# Install Timeshift if missing
if ! command -v timeshift >/dev/null; then
  sudo apt update
  sudo apt install $APT_FLAGS timeshift
fi

# Create Timeshift snapshot
echo "Creating Timeshift snapshot..."
sudo timeshift --create --comments "Before ubuntu-bootstrap" --tags D

export APT_FLAGS
echo "Preflight completed."
