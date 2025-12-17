#!/usr/bin/env bash
set -e

echo "Installing Snap applications..."

for snap in discord telegram-desktop ; do
  if ! snap list | grep -q "^$snap"; then
    sudo snap install "$snap"
  fi
done


for snap in code flutter android-studio gitkraken ; do
  if ! snap list | grep -q "^$snap"; then
    sudo snap install "$snap" --classic
  fi
done

echo "Snap installation completed."
